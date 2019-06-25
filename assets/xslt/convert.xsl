<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<xsl:output method="html" encoding="UTF-8"/>
	<xsl:variable name="imgbasepath" select="./input" />

	<xsl:template match="/">
	  <HTML>
	  	<BODY>
	  		<h2><xsl:value-of select="$imgbasepath" /></h2>
	  		<xsl:apply-templates/>
	  	</BODY>
	  </HTML>
	</xsl:template> 

	<xsl:template match="chat-tab-list">
		<TABLE border="1">
			<tr> <th>tab</th> <th>name</th> <th>image</th> <th>message</th> <th>time</th> </tr>
			<xsl:apply-templates select="chat-tab/chat">
					<xsl:sort select="@timestamp" data-type="number" order="ascending"/>
			</xsl:apply-templates>
		</TABLE>
	</xsl:template> 

	<xsl:template match="chat-tab/chat">
		<tr> 
			<td><xsl:value-of select="../@name"/></td>
			<td><xsl:value-of select="@name"/></td> 
			<td>
				<img width="50px"> 
					<xsl:attribute name="src">
						<xsl:choose>
							<xsl:when test="count(@imageIdentifier)>0">./img/<xsl:value-of select="@imageIdentifier" />.imagedata</xsl:when>
							<xsl:otherwise>./img/none_icon.imagedata</xsl:otherwise>
						</xsl:choose>
					</xsl:attribute>
				</img>
			</td> 
			<td><xsl:value-of select="."/></td>
			<td><xsl:value-of select="@timestamp"/></td> 
		</tr>
	</xsl:template>
	
	<xsl:template match="chat">
		
	</xsl:template>

</xsl:stylesheet>