package com.dt.framework.util;

import org.apache.tiles.Attribute;
import org.apache.tiles.AttributeContext;
import org.apache.tiles.context.TilesRequestContext;
import org.apache.tiles.preparer.ViewPreparer;

/**
 * @author wei
 *
 */
public class TilesPreparer implements ViewPreparer {

	@Override
	public void execute(TilesRequestContext tilesContext, AttributeContext attributeContext) {
		if (attributeContext.getAttribute("title") != null) {
			String titleKey = (String) attributeContext.getAttribute("title").getValue();

			String title = "";
			try {
				title = TextUtil.getText(titleKey);
			} catch (Exception e) {
				title = titleKey + ":not found";
			}

			attributeContext.putAttribute("page.title", new Attribute(title));
		}
	}
	
}
