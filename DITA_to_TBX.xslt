<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">
    <xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"/>

    <xsl:strip-space elements="*"/>

    <xsl:template match="/">
        <xsl:element name="martif">
            <xsl:attribute name="type">TBX</xsl:attribute>
            <xsl:if test="dita/@xml:lang">
                <xsl:attribute name="xml:lang"><xsl:value-of select="dita/@xml:lang"/></xsl:attribute>
            </xsl:if>
            <xsl:element name="martifHeader">
                <xsl:element name="fileDesc">
                    <xsl:element name="titleStmt">
                        <xsl:element name="title">Terminology</xsl:element>
                    </xsl:element>
                    <xsl:element name="sourceDesc">
                        <xsl:element name="p">TBX transformation from DITA</xsl:element>
                    </xsl:element>
                </xsl:element>
                <xsl:element name="encodingDesc">
                    <xsl:element name="p"><xsl:attribute name="type">XCSURI</xsl:attribute>schema.xcs</xsl:element>
                </xsl:element>
            </xsl:element>
            <xsl:element name="text">
                <xsl:element name="body">
                    <xsl:apply-templates/>
                </xsl:element>
            </xsl:element>
        </xsl:element>
    </xsl:template>

    <xsl:template match="dita">
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="body">
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="topic">
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="title"/>

    <xsl:template match="section">
        <xsl:element name="termEntry">
            <xsl:attribute name="id">
                <xsl:value-of select="position()"/>
            </xsl:attribute>
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>

    <xsl:template match="p">
        <xsl:element name="langSet">
            <xsl:attribute name="xml:lang">
                <xsl:value-of select="child::term/@xml:lang"/>
            </xsl:attribute>
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>

    <xsl:template match="term">
        <xsl:element name="tig">
            <xsl:element name="term">
                <xsl:attribute name="id">
                    <xsl:value-of select="concat(self::*/@xml:lang, '-', ancestor::section/@id)"/>
                </xsl:attribute>
                <xsl:apply-templates/>
            </xsl:element>
        </xsl:element>
    </xsl:template>

    <xsl:template match="//*[@othertype]">
        <xsl:element name="descrip">
            <xsl:attribute name="type"><xsl:value-of select="self::*/@othertype"/></xsl:attribute>
            <xsl:value-of select="normalize-space(self::*)"/>
        </xsl:element>
    </xsl:template>

</xsl:stylesheet>