package com.manage.base.exception;

import com.manage.base.supplier.msgs.MessageErrors;

/**
 * Created by bert on 17-8-8.
 */
public class NewsNotFoundException extends NotFoundException {

    public NewsNotFoundException() {
        super(MessageErrors.NEWS_NOT_FOUND);
    }

}
