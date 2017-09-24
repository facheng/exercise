package com.dt.tarmag.vo;

import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.poi.hssf.eventusermodel.HSSFEventFactory;
import org.apache.poi.hssf.eventusermodel.HSSFListener;
import org.apache.poi.hssf.eventusermodel.HSSFRequest;
import org.apache.poi.hssf.record.BOFRecord;
import org.apache.poi.hssf.record.BoundSheetRecord;
import org.apache.poi.hssf.record.NumberRecord;
import org.apache.poi.hssf.record.Record;
import org.apache.poi.hssf.record.RowRecord;
import org.apache.poi.hssf.record.SSTRecord;
import org.apache.poi.poifs.filesystem.POIFSFileSystem;

public class TestExport {


    List<String> violations = new ArrayList<String>();
    List<String[]> lines = new ArrayList<String[]>();
    Map<MasterDataType, List<String[]>> data = new HashMap<MasterDataType, List<String[]>>();
    
    private enum MasterDataType{
    	ShipFrom,ShipTo,Cargo;
    }

    public void importXls(File file, boolean isStrictValidation, Long companyConfigId,
            Long ownerId, Long otmsLocationId, boolean supportsLocation, boolean supportsXtt, boolean isUpdate) {
        try {
            data.put(MasterDataType.ShipFrom, new ArrayList<String[]>());
            data.put(MasterDataType.ShipTo, new ArrayList<String[]>());
            data.put(MasterDataType.Cargo, new ArrayList<String[]>());
            FileInputStream fis = new FileInputStream(file);
            POIFSFileSystem poifs = new POIFSFileSystem(fis);
            InputStream dataInput = poifs.createDocumentInputStream("Workbook");
            HSSFRequest request = new HSSFRequest();
            request.addListenerForAllRecords(new ProcessMasterDataXLS());
            HSSFEventFactory factory = new HSSFEventFactory();
            factory.processEvents(request, dataInput);
            fis.close();
            dataInput.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

    }

    /**
     * 
     * This class converts XLS files into String so we can user previous
     * implementation of import (csv) that works. As a result there is a
     * String[] that contains lines-rows from xls
     * 
     */
    public class ProcessMasterDataXLS implements HSSFListener {
        private SSTRecord sstrec;
        private MasterDataType type = null;
        private String[] line = setUpLine();

        /**
         * This method listens for incoming records and handles them as
         * required.
         * 
         * @param record
         *            The record that was found while reading.
         */
        public void processRecord(Record record) {
            switch (record.getSid()) {
            // the BOFRecord can represent either the beginning of a sheet or
            // the workbook
            case BOFRecord.sid:
                BOFRecord bof = (BOFRecord) record;
                if (bof.getType() == BOFRecord.TYPE_WORKSHEET) {
                    // change sheet
                    if (type == null) {
                        // next sheet is
                        type = MasterDataType.ShipFrom;
                        return;
                    }
                    if (type == MasterDataType.ShipFrom) {
                        // next sheet is
                        type = MasterDataType.ShipTo;
                        return;
                    }
                    if (type == MasterDataType.ShipTo) {
                        // next sheet is
                        type = MasterDataType.Cargo;
                        return;
                    }
                } else if (bof.getType() == BOFRecord.TYPE_WORKBOOK) {
                }
                break;
            case BoundSheetRecord.sid:
            case RowRecord.sid:
                break;
            case SSTRecord.sid:
                // SSTRecords store a array of unique strings used in Excel.
                // process this record without action
                sstrec = (SSTRecord) record;
                for (int k = 0; k < sstrec.getNumUniqueStrings(); k++) {
                }
                break;
            case NumberRecord.sid:
                NumberRecord numrec = (NumberRecord) record;
                // skip header
                if (numrec.getRow() != 0) {
                    // handle row change
                    if (numrec.getColumn() == 0) {
                        line = setUpLine();
                        data.get(type).add(line);
                    }
                    if (numrec.getColumn() < ImportColumnDefinition.MAX_COLS) {
                        line[numrec.getColumn()] = processNumerciValue(numrec.getValue(), numrec.getColumn(), type);
                    } else {
                        LOG.info("value out of bound 57 / {}", numrec.getColumn());
                    }
                }
                break;
            case LabelSSTRecord.sid:
                // string record
                LabelSSTRecord lrec = (LabelSSTRecord) record;
                if (lrec.getRow() != 0) {
                    if (lrec.getColumn() == 0) {
                        line = setUpLine();
                        data.get(type).add(line);
                    }
                    if (lrec.getColumn() < ImportColumnDefinition.MAX_COLS) {
                        line[lrec.getColumn()] = sstrec.getString(lrec.getSSTIndex()).toString();
                    } else {
                        LOG.info("value out of bound 57 / {}", lrec.getColumn());
                    }
                }
                break;
            }
        }
    }

    private String processNumerciValue(double value, short column, MasterDataType type) {
        BigDecimal numeric = BigDecimal.valueOf(value);
        switch (type) {
        case ShipFrom:
        case ShipTo:
            if (isLocationColNumeric(column)) {
                return numeric.toPlainString();
            } else {
                // can throw an exception. return invalid number message for
                // column...
                return numeric.setScale(0, RoundingMode.UNNECESSARY).toPlainString();
            }

        case Cargo:
            if (isCargoColNumeric(column)) {
                return numeric.toPlainString();
            } else {
                // can throw an exception
                return numeric.setScale(0, RoundingMode.UNNECESSARY).toPlainString();
            }
        default:
            return numeric.toPlainString();
        }

    }

    private String[] setUpLine() {
        String[] line = new String[ImportColumnDefinition.MAX_COLS];
        for (int i = 0; i < ImportColumnDefinition.MAX_COLS; i++)
            line[i] = StringUtils.EMPTY;
        return line;
    }

    private boolean isLocationColNumeric(short column) {
        return column == ImportColumnDefinition.NUMCF1 || column == ImportColumnDefinition.NUMCF2
                || column == ImportColumnDefinition.NUMCF3 || column == ImportColumnDefinition.NUMCF4
                || column == ImportColumnDefinition.NUMCF5 || column == ImportColumnDefinition.NUMCF6
                || column == ImportColumnDefinition.NUMCF7 || column == ImportColumnDefinition.NUMCF8
                || column == ImportColumnDefinition.NUMCF9 || column == ImportColumnDefinition.NUMCF10;
    }

    private boolean isCargoColNumeric(short column) {
        return column == ImportColumnDefinition.CARGO_HEIGHT || column == ImportColumnDefinition.CARGO_LENGTH
                || column == ImportColumnDefinition.CARGO_WIDTH || column == ImportColumnDefinition.CARGO_WEIGHT
                || column == ImportColumnDefinition.CARGO_NUMCF1 || column == ImportColumnDefinition.CARGO_NUMCF2
                || column == ImportColumnDefinition.CARGO_NUMCF3 || column == ImportColumnDefinition.CARGO_NUMCF4
                || column == ImportColumnDefinition.CARGO_NUMCF5 || column == ImportColumnDefinition.CARGO_NUMCF6
                || column == ImportColumnDefinition.CARGO_NUMCF7 || column == ImportColumnDefinition.CARGO_NUMCF8
                || column == ImportColumnDefinition.CARGO_NUMCF9 || column == ImportColumnDefinition.CARGO_NUMCF10
                || column == ImportColumnDefinition.CARGO_INSURANCE;
    }

    public static String invalidColsInLocation = "invalid.cols.in.location";
    public static String invalidColsInCargo = "invalid.cols.in.cargo";}
