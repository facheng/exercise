package com.manage.kernel.jpa.base;

import com.manage.kernel.jpa.entity.ProcessFlow;

import javax.persistence.Column;
import javax.persistence.Embeddable;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.OneToOne;

@Embeddable
public class Process {

    @Column(name = "execution_id", updatable = false, insertable = false)
    private String executionId;

    @OneToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "execution_id", referencedColumnName = "execution_id")
    private ProcessFlow processFlow;

    public String getExecutionId() {
        return executionId;
    }

    public void setExecutionId(String executionId) {
        this.executionId = executionId;
    }

    public ProcessFlow getProcessFlow() {
        return processFlow;
    }

    public void setProcessFlow(ProcessFlow processFlow) {
        this.processFlow = processFlow;
    }
}
