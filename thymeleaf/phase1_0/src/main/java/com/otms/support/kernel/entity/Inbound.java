package com.otms.support.kernel.entity;

import com.otms.support.supplier.database.enums.APISource;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;

import com.otms.support.supplier.database.enums.Direction;
import org.hibernate.annotations.Parameter;
import org.hibernate.annotations.Type;
import org.joda.time.LocalDateTime;

/**
 * Created by bert on 17-9-11.
 */

@Entity
@Table(name = "ws_inbound")
@SequenceGenerator(name = "seq_ws_inbound", sequenceName = "seq_ws_inbound", allocationSize = 1)
public class Inbound {

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "seq_ws_inbound")
    private Long id;

    @Column(name = "payload", columnDefinition = "TEXT")
    private String payload;

    @Column(name = "remote_ip")
    private String remoteIp;

    @Column(name = "api_source")
    @Type(type = "com.otms.support.supplier.database.define.DBEnumType", parameters = {
            @Parameter(name = "enumClass", value = "com.otms.support.supplier.database.enums.APISource")})
    private APISource apiSource;

    @Column(name = "created_on")
    @Type(type = "org.jadira.usertype.dateandtime.joda.PersistentLocalDateTime")
    private LocalDateTime createdOn;


    @Column(name = "direction")
    @Type(type = "com.otms.support.supplier.database.define.DBEnumType", parameters = {
            @Parameter(name = "enumClass", value = "com.otms.support.supplier.database.enums.Direction")})
    private Direction direction;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public LocalDateTime getCreatedOn() {
        return createdOn;
    }

    public void setCreatedOn(LocalDateTime createdOn) {
        this.createdOn = createdOn;
    }

    public String getRemoteIp() {
        return remoteIp;
    }

    public void setRemoteIp(String remoteIp) {
        this.remoteIp = remoteIp;
    }

    public APISource getApiSource() {
        return apiSource;
    }

    public void setApiSource(APISource apiSource) {
        this.apiSource = apiSource;
    }

    public String getPayload() {
        return payload;
    }

    public void setPayload(String payload) {
        this.payload = payload;
    }

    public Direction getDirection() {
        return direction;
    }

    public void setDirection(Direction direction) {
        this.direction = direction;
    }
}
