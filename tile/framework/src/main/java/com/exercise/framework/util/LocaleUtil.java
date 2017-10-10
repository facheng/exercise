package com.dt.framework.util;

import java.util.Locale;
import javax.servlet.http.HttpServletRequest;
import org.springframework.beans.propertyeditors.LocaleEditor;
import org.springframework.web.servlet.LocaleResolver;
import org.springframework.web.servlet.support.RequestContextUtils;

/**
 * @author wei
 *
 */
public class LocaleUtil {
	
	private LocaleUtil(){}
	
	public static Locale getLocale(){
		HttpServletRequest request = ActionUtil.getRequest();
		LocaleResolver localeResolver = RequestContextUtils.getLocaleResolver(request);
		return localeResolver.resolveLocale(request);
	}
	
	public static void setLocale(String locale){
		setLocale(getLocaleFromString(locale));
	}

	private static void setLocale(Locale locale){
		HttpServletRequest request = ActionUtil.getRequest();
		LocaleResolver localeResolver = RequestContextUtils.getLocaleResolver(request);
		LocaleEditor localeEditor = new LocaleEditor();
		localeEditor.setAsText(locale.toString());
		localeResolver.setLocale(request, null, locale);
	}
	
	public static Locale getLocaleFromString(String localeStr){
		Locale defaultLocale = Locale.getDefault();
        if ((localeStr == null) || (localeStr.trim().length() == 0) || ("_".equals(localeStr))) {
            if (defaultLocale != null) {
                return defaultLocale;
            }
            return Locale.getDefault();
        }

        int index = localeStr.indexOf('_');
        if (index < 0) {
            return new Locale(localeStr);
        }

        String language = localeStr.substring(0, index);
        if (index == localeStr.length()) {
            return new Locale(language);
        }

        localeStr = localeStr.substring(index + 1);
        index = localeStr.indexOf('_');
        if (index < 0) {
            return new Locale(language, localeStr);
        }

        String country = localeStr.substring(0, index);
        if (index == localeStr.length()) {
            return new Locale(language, country);
        }

        localeStr = localeStr.substring(index + 1);
        return new Locale(language, country, localeStr);
    }

	///////////////////////////////////////////////////////////////////////////////////////////////
	
}
