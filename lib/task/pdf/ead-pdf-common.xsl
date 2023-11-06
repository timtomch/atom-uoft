<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:ns2="http://www.w3.org/1999/xlink" xmlns:local="http://www.yoursite.org/namespace" xmlns:ead="urn:isbn:1-931666-22-9" xmlns:fo="http://www.w3.org/1999/XSL/Format" version="2.0" exclude-result-prefixes="#all">
    <!--
        *******************************************************************
        *                                                                 *
        * VERSION:      2.1.1                                             *
        *                                                                 *
        * AUTHOR:       Winona Salesky                                    *
        *               wsalesky@gmail.com                                *
        *                                                                 *
        * MODIFIED BY:  mikeg@artefactual.com                             *
        *               david@artefactual.com                             *
        *                                                                 *
        * DATE:         2022-06-07                                        *
        *                                                                 *
        *******************************************************************
    -->
    <xsl:output method="xml" encoding="utf-8" indent="yes"/>
    <xsl:strip-space elements="*"/>
    <!-- Define keys -->
    <xsl:key name="physlocId" match="ead:physloc" use="@id"/>
    <xsl:key name="languageCode" match="language" use="@iso639-2T"/>
    <!-- The following attribute sets are reusabe styles used throughout the stylesheet. -->
    <!-- Headings -->
    <xsl:attribute-set name="h1">
        <xsl:attribute name="font-size">22pt</xsl:attribute>
        <xsl:attribute name="font-weight">bold</xsl:attribute>
        <xsl:attribute name="margin-top">16pt</xsl:attribute>
        <xsl:attribute name="margin-bottom">8pt</xsl:attribute>
    </xsl:attribute-set>
    <xsl:attribute-set name="h2">
        <xsl:attribute name="font-size">16pt</xsl:attribute>
        <xsl:attribute name="font-weight">bold</xsl:attribute>
        <xsl:attribute name="border-top">4pt solid #333</xsl:attribute>
        <xsl:attribute name="border-bottom">1pt dotted #333</xsl:attribute>
        <xsl:attribute name="margin-bottom">12pt</xsl:attribute>
        <xsl:attribute name="margin-top">4pt</xsl:attribute>
        <xsl:attribute name="padding-top">8pt</xsl:attribute>
        <xsl:attribute name="padding-bottom">8pt</xsl:attribute>
        <xsl:attribute name="keep-with-next.within-page">always</xsl:attribute>
    </xsl:attribute-set>
    <xsl:attribute-set name="h3">
        <xsl:attribute name="font-size">14pt</xsl:attribute>
        <xsl:attribute name="font-weight">bold</xsl:attribute>
        <xsl:attribute name="margin-bottom">4pt</xsl:attribute>
        <xsl:attribute name="padding-bottom">0</xsl:attribute>
        <xsl:attribute name="keep-with-next.within-page">always</xsl:attribute>
    </xsl:attribute-set>
    <xsl:attribute-set name="h4">
        <xsl:attribute name="font-size">12pt</xsl:attribute>
        <xsl:attribute name="font-weight">bold</xsl:attribute>
        <xsl:attribute name="margin-bottom">4pt</xsl:attribute>
        <xsl:attribute name="padding-bottom">0</xsl:attribute>
        <xsl:attribute name="keep-with-next.within-page">always</xsl:attribute>
    </xsl:attribute-set>
    <!-- Headings with id attribute -->
    <xsl:attribute-set name="h1ID" use-attribute-sets="h1">
        <xsl:attribute name="id">
            <xsl:value-of select="local:buildID(.)"/>
        </xsl:attribute>
    </xsl:attribute-set>
    <xsl:attribute-set name="h2ID" use-attribute-sets="h2">
        <xsl:attribute name="id">
            <xsl:value-of select="local:buildID(.)"/>
        </xsl:attribute>
    </xsl:attribute-set>
    <xsl:attribute-set name="h3ID" use-attribute-sets="h3">
        <xsl:attribute name="id">
            <xsl:value-of select="local:buildID(.)"/>
        </xsl:attribute>
    </xsl:attribute-set>
    <xsl:attribute-set name="h4ID" use-attribute-sets="h4">
        <xsl:attribute name="id">
            <xsl:value-of select="local:buildID(.)"/>
        </xsl:attribute>
    </xsl:attribute-set>
    <!-- Linking attributes styles -->
    <xsl:attribute-set name="ref">
        <xsl:attribute name="color">#14A6DC</xsl:attribute>
        <xsl:attribute name="text-decoration">underline</xsl:attribute>
    </xsl:attribute-set>
    <!-- Standard margin and padding for most fo:block elements, including paragraphs -->
    <xsl:attribute-set name="smp">
        <xsl:attribute name="margin">4pt</xsl:attribute>
        <xsl:attribute name="padding">4pt</xsl:attribute>
    </xsl:attribute-set>
    <!-- Standard margin and padding for elements with in the dsc table -->
    <xsl:attribute-set name="smpDsc">
        <xsl:attribute name="font-size">12pt</xsl:attribute>
        <xsl:attribute name="margin">2pt</xsl:attribute>
        <xsl:attribute name="padding">2pt</xsl:attribute>
    </xsl:attribute-set>
    <!-- Styles for main sections -->
    <xsl:attribute-set name="section">
        <xsl:attribute name="margin">4pt</xsl:attribute>
        <xsl:attribute name="padding">2pt</xsl:attribute>
    </xsl:attribute-set>
    <!-- Styles for table sections -->
    <xsl:attribute-set name="sectionTable">
        <xsl:attribute name="margin">4pt</xsl:attribute>
        <xsl:attribute name="padding">4pt</xsl:attribute>
        <xsl:attribute name="left">4pt</xsl:attribute>
    </xsl:attribute-set>
    <!-- Table attributes for tables with borders -->
    <xsl:attribute-set name="tableBorder">
        <xsl:attribute name="table-layout">fixed</xsl:attribute>
        <xsl:attribute name="width">100%</xsl:attribute>
        <xsl:attribute name="border">.5pt solid #000</xsl:attribute>
        <xsl:attribute name="border-collapse">separate</xsl:attribute>
        <xsl:attribute name="space-after">12pt</xsl:attribute>
    </xsl:attribute-set>
    <!-- Table headings -->
    <xsl:attribute-set name="th">
        <xsl:attribute name="background-color">#000</xsl:attribute>
        <xsl:attribute name="font-weight">bold</xsl:attribute>
        <xsl:attribute name="text-align">left</xsl:attribute>
    </xsl:attribute-set>
    <!-- Table cells with borders -->
    <xsl:attribute-set name="tdBorder">
        <xsl:attribute name="border">.5pt solid #000</xsl:attribute>
        <xsl:attribute name="border-collapse">separate</xsl:attribute>
    </xsl:attribute-set>
    <!-- Language code look-up map -->
    <xsl:variable name="languages">
        <languages>
            <language name="Abkhazian" iso639-1="ab" iso639-2T="abk" iso639-2B="abk" iso639-3="abk"/>
            <language name="Afar" iso639-1="aa" iso639-2T="aar" iso639-2B="aar" iso639-3="aar"/>
            <language name="Afrikaans" iso639-1="af" iso639-2T="afr" iso639-2B="afr" iso639-3="afr"/>
            <language name="Akan" iso639-1="ak" iso639-2T="aka" iso639-2B="aka" iso639-3="aka"/>
            <language name="Albanian" iso639-1="sq" iso639-2T="sqi" iso639-2B="alb" iso639-3="sqi"/>
            <language name="Amharic" iso639-1="am" iso639-2T="amh" iso639-2B="amh" iso639-3="amh"/>
            <language name="Arabic" iso639-1="ar" iso639-2T="ara" iso639-2B="ara" iso639-3="ara"/>
            <language name="Aragonese" iso639-1="an" iso639-2T="arg" iso639-2B="arg" iso639-3="arg"/>
            <language name="Armenian" iso639-1="hy" iso639-2T="hye" iso639-2B="arm" iso639-3="hye"/>
            <language name="Assamese" iso639-1="as" iso639-2T="asm" iso639-2B="asm" iso639-3="asm"/>
            <language name="Avaric" iso639-1="av" iso639-2T="ava" iso639-2B="ava" iso639-3="ava"/>
            <language name="Avestan" iso639-1="ae" iso639-2T="ave" iso639-2B="ave" iso639-3="ave"/>
            <language name="Aymara" iso639-1="ay" iso639-2T="aym" iso639-2B="aym" iso639-3="aym"/>
            <language name="Azerbaijani" iso639-1="az" iso639-2T="aze" iso639-2B="aze" iso639-3="aze"/>
            <language name="Bambara" iso639-1="bm" iso639-2T="bam" iso639-2B="bam" iso639-3="bam"/>
            <language name="Bashkir" iso639-1="ba" iso639-2T="bak" iso639-2B="bak" iso639-3="bak"/>
            <language name="Basque" iso639-1="eu" iso639-2T="eus" iso639-2B="baq" iso639-3="eus"/>
            <language name="Belarusian" iso639-1="be" iso639-2T="bel" iso639-2B="bel" iso639-3="bel"/>
            <language name="Bengali" iso639-1="bn" iso639-2T="ben" iso639-2B="ben" iso639-3="ben"/>
            <language name="Bislama" iso639-1="bi" iso639-2T="bis" iso639-2B="bis" iso639-3="bis"/>
            <language name="Bosnian" iso639-1="bs" iso639-2T="bos" iso639-2B="bos" iso639-3="bos"/>
            <language name="Breton" iso639-1="br" iso639-2T="bre" iso639-2B="bre" iso639-3="bre"/>
            <language name="Bulgarian" iso639-1="bg" iso639-2T="bul" iso639-2B="bul" iso639-3="bul"/>
            <language name="Burmese" iso639-1="my" iso639-2T="mya" iso639-2B="bur" iso639-3="mya"/>
            <language name="Catalan, Valencian" iso639-1="ca" iso639-2T="cat" iso639-2B="cat" iso639-3="cat"/>
            <language name="Chamorro" iso639-1="ch" iso639-2T="cha" iso639-2B="cha" iso639-3="cha"/>
            <language name="Chechen" iso639-1="ce" iso639-2T="che" iso639-2B="che" iso639-3="che"/>
            <language name="Chichewa, Chewa, Nyanja" iso639-1="ny" iso639-2T="nya" iso639-2B="nya" iso639-3="nya"/>
            <language name="Chinese" iso639-1="zh" iso639-2T="zho" iso639-2B="chi" iso639-3="zho"/>
            <language name="Church Slavonic, Old Slavonic, Old Church Slavonic" iso639-1="cu" iso639-2T="chu" iso639-2B="chu" iso639-3="chu"/>
            <language name="Chuvash" iso639-1="cv" iso639-2T="chv" iso639-2B="chv" iso639-3="chv"/>
            <language name="Cornish" iso639-1="kw" iso639-2T="cor" iso639-2B="cor" iso639-3="cor"/>
            <language name="Corsican" iso639-1="co" iso639-2T="cos" iso639-2B="cos" iso639-3="cos"/>
            <language name="Cree" iso639-1="cr" iso639-2T="cre" iso639-2B="cre" iso639-3="cre"/>
            <language name="Croatian" iso639-1="hr" iso639-2T="hrv" iso639-2B="hrv" iso639-3="hrv"/>
            <language name="Czech" iso639-1="cs" iso639-2T="ces" iso639-2B="cze" iso639-3="ces"/>
            <language name="Danish" iso639-1="da" iso639-2T="dan" iso639-2B="dan" iso639-3="dan"/>
            <language name="Divehi, Dhivehi, Maldivian" iso639-1="dv" iso639-2T="div" iso639-2B="div" iso639-3="div"/>
            <language name="Dutch, Flemish" iso639-1="nl" iso639-2T="nld" iso639-2B="dut" iso639-3="nld"/>
            <language name="Dzongkha" iso639-1="dz" iso639-2T="dzo" iso639-2B="dzo" iso639-3="dzo"/>
            <language name="English" iso639-1="en" iso639-2T="eng" iso639-2B="eng" iso639-3="eng"/>
            <language name="Esperanto" iso639-1="eo" iso639-2T="epo" iso639-2B="epo" iso639-3="epo"/>
            <language name="Estonian" iso639-1="et" iso639-2T="est" iso639-2B="est" iso639-3="est"/>
            <language name="Ewe" iso639-1="ee" iso639-2T="ewe" iso639-2B="ewe" iso639-3="ewe"/>
            <language name="Faroese" iso639-1="fo" iso639-2T="fao" iso639-2B="fao" iso639-3="fao"/>
            <language name="Fijian" iso639-1="fj" iso639-2T="fij" iso639-2B="fij" iso639-3="fij"/>
            <language name="Finnish" iso639-1="fi" iso639-2T="fin" iso639-2B="fin" iso639-3="fin"/>
            <language name="French" iso639-1="fr" iso639-2T="fra" iso639-2B="fre" iso639-3="fra"/>
            <language name="Western Frisian" iso639-1="fy" iso639-2T="fry" iso639-2B="fry" iso639-3="fry"/>
            <language name="Fulah" iso639-1="ff" iso639-2T="ful" iso639-2B="ful" iso639-3="ful"/>
            <language name="Gaelic, Scottish Gaelic" iso639-1="gd" iso639-2T="gla" iso639-2B="gla" iso639-3="gla"/>
            <language name="Galician" iso639-1="gl" iso639-2T="glg" iso639-2B="glg" iso639-3="glg"/>
            <language name="Ganda" iso639-1="lg" iso639-2T="lug" iso639-2B="lug" iso639-3="lug"/>
            <language name="Georgian" iso639-1="ka" iso639-2T="kat" iso639-2B="geo" iso639-3="kat"/>
            <language name="German" iso639-1="de" iso639-2T="deu" iso639-2B="ger" iso639-3="deu"/>
            <language name="Greek, Modern (1453–)" iso639-1="el" iso639-2T="ell" iso639-2B="gre" iso639-3="ell"/>
            <language name="Kalaallisut, Greenlandic" iso639-1="kl" iso639-2T="kal" iso639-2B="kal" iso639-3="kal"/>
            <language name="Guarani" iso639-1="gn" iso639-2T="grn" iso639-2B="grn" iso639-3="grn"/>
            <language name="Gujarati" iso639-1="gu" iso639-2T="guj" iso639-2B="guj" iso639-3="guj"/>
            <language name="Haitian, Haitian Creole" iso639-1="ht" iso639-2T="hat" iso639-2B="hat" iso639-3="hat"/>
            <language name="Hausa" iso639-1="ha" iso639-2T="hau" iso639-2B="hau" iso639-3="hau"/>
            <language name="Hebrew" iso639-1="he" iso639-2T="heb" iso639-2B="heb" iso639-3="heb"/>
            <language name="Herero" iso639-1="hz" iso639-2T="her" iso639-2B="her" iso639-3="her"/>
            <language name="Hindi" iso639-1="hi" iso639-2T="hin" iso639-2B="hin" iso639-3="hin"/>
            <language name="Hiri Motu" iso639-1="ho" iso639-2T="hmo" iso639-2B="hmo" iso639-3="hmo"/>
            <language name="Hungarian" iso639-1="hu" iso639-2T="hun" iso639-2B="hun" iso639-3="hun"/>
            <language name="Icelandic" iso639-1="is" iso639-2T="isl" iso639-2B="ice" iso639-3="isl"/>
            <language name="Ido" iso639-1="io" iso639-2T="ido" iso639-2B="ido" iso639-3="ido"/>
            <language name="Igbo" iso639-1="ig" iso639-2T="ibo" iso639-2B="ibo" iso639-3="ibo"/>
            <language name="Indonesian" iso639-1="id" iso639-2T="ind" iso639-2B="ind" iso639-3="ind"/>
            <language name="Interlingua (International Auxiliary Language Association)" iso639-1="ia" iso639-2T="ina" iso639-2B="ina" iso639-3="ina"/>
            <language name="Interlingue, Occidental" iso639-1="ie" iso639-2T="ile" iso639-2B="ile" iso639-3="ile"/>
            <language name="Inuktitut" iso639-1="iu" iso639-2T="iku" iso639-2B="iku" iso639-3="iku"/>
            <language name="Inupiaq" iso639-1="ik" iso639-2T="ipk" iso639-2B="ipk" iso639-3="ipk"/>
            <language name="Irish" iso639-1="ga" iso639-2T="gle" iso639-2B="gle" iso639-3="gle"/>
            <language name="Italian" iso639-1="it" iso639-2T="ita" iso639-2B="ita" iso639-3="ita"/>
            <language name="Japanese" iso639-1="ja" iso639-2T="jpn" iso639-2B="jpn" iso639-3="jpn"/>
            <language name="Javanese" iso639-1="jv" iso639-2T="jav" iso639-2B="jav" iso639-3="jav"/>
            <language name="Kannada" iso639-1="kn" iso639-2T="kan" iso639-2B="kan" iso639-3="kan"/>
            <language name="Kanuri" iso639-1="kr" iso639-2T="kau" iso639-2B="kau" iso639-3="kau"/>
            <language name="Kashmiri" iso639-1="ks" iso639-2T="kas" iso639-2B="kas" iso639-3="kas"/>
            <language name="Kazakh" iso639-1="kk" iso639-2T="kaz" iso639-2B="kaz" iso639-3="kaz"/>
            <language name="Central Khmer" iso639-1="km" iso639-2T="khm" iso639-2B="khm" iso639-3="khm"/>
            <language name="Kikuyu, Gikuyu" iso639-1="ki" iso639-2T="kik" iso639-2B="kik" iso639-3="kik"/>
            <language name="Kinyarwanda" iso639-1="rw" iso639-2T="kin" iso639-2B="kin" iso639-3="kin"/>
            <language name="Kirghiz, Kyrgyz" iso639-1="ky" iso639-2T="kir" iso639-2B="kir" iso639-3="kir"/>
            <language name="Komi" iso639-1="kv" iso639-2T="kom" iso639-2B="kom" iso639-3="kom"/>
            <language name="Kongo" iso639-1="kg" iso639-2T="kon" iso639-2B="kon" iso639-3="kon"/>
            <language name="Korean" iso639-1="ko" iso639-2T="kor" iso639-2B="kor" iso639-3="kor"/>
            <language name="Kuanyama, Kwanyama" iso639-1="kj" iso639-2T="kua" iso639-2B="kua" iso639-3="kua"/>
            <language name="Kurdish" iso639-1="ku" iso639-2T="kur" iso639-2B="kur" iso639-3="kur"/>
            <language name="Lao" iso639-1="lo" iso639-2T="lao" iso639-2B="lao" iso639-3="lao"/>
            <language name="Latin" iso639-1="la" iso639-2T="lat" iso639-2B="lat" iso639-3="lat"/>
            <language name="Latvian" iso639-1="lv" iso639-2T="lav" iso639-2B="lav" iso639-3="lav"/>
            <language name="Limburgan, Limburger, Limburgish" iso639-1="li" iso639-2T="lim" iso639-2B="lim" iso639-3="lim"/>
            <language name="Lingala" iso639-1="ln" iso639-2T="lin" iso639-2B="lin" iso639-3="lin"/>
            <language name="Lithuanian" iso639-1="lt" iso639-2T="lit" iso639-2B="lit" iso639-3="lit"/>
            <language name="Luba-Katanga" iso639-1="lu" iso639-2T="lub" iso639-2B="lub" iso639-3="lub"/>
            <language name="Luxembourgish, Letzeburgesch" iso639-1="lb" iso639-2T="ltz" iso639-2B="ltz" iso639-3="ltz"/>
            <language name="Macedonian" iso639-1="mk" iso639-2T="mkd" iso639-2B="mac" iso639-3="mkd"/>
            <language name="Malagasy" iso639-1="mg" iso639-2T="mlg" iso639-2B="mlg" iso639-3="mlg"/>
            <language name="Malay" iso639-1="ms" iso639-2T="msa" iso639-2B="may" iso639-3="msa"/>
            <language name="Malayalam" iso639-1="ml" iso639-2T="mal" iso639-2B="mal" iso639-3="mal"/>
            <language name="Maltese" iso639-1="mt" iso639-2T="mlt" iso639-2B="mlt" iso639-3="mlt"/>
            <language name="Manx" iso639-1="gv" iso639-2T="glv" iso639-2B="glv" iso639-3="glv"/>
            <language name="Maori" iso639-1="mi" iso639-2T="mri" iso639-2B="mao" iso639-3="mri"/>
            <language name="Marathi" iso639-1="mr" iso639-2T="mar" iso639-2B="mar" iso639-3="mar"/>
            <language name="Marshallese" iso639-1="mh" iso639-2T="mah" iso639-2B="mah" iso639-3="mah"/>
            <language name="Mongolian" iso639-1="mn" iso639-2T="mon" iso639-2B="mon" iso639-3="mon"/>
            <language name="Nauru" iso639-1="na" iso639-2T="nau" iso639-2B="nau" iso639-3="nau"/>
            <language name="Navajo, Navaho" iso639-1="nv" iso639-2T="nav" iso639-2B="nav" iso639-3="nav"/>
            <language name="North Ndebele" iso639-1="nd" iso639-2T="nde" iso639-2B="nde" iso639-3="nde"/>
            <language name="South Ndebele" iso639-1="nr" iso639-2T="nbl" iso639-2B="nbl" iso639-3="nbl"/>
            <language name="Ndonga" iso639-1="ng" iso639-2T="ndo" iso639-2B="ndo" iso639-3="ndo"/>
            <language name="Nepali" iso639-1="ne" iso639-2T="nep" iso639-2B="nep" iso639-3="nep"/>
            <language name="Norwegian" iso639-1="no" iso639-2T="nor" iso639-2B="nor" iso639-3="nor"/>
            <language name="Norwegian Bokmål" iso639-1="nb" iso639-2T="nob" iso639-2B="nob" iso639-3="nob"/>
            <language name="Norwegian Nynorsk" iso639-1="nn" iso639-2T="nno" iso639-2B="nno" iso639-3="nno"/>
            <language name="Sichuan Yi, Nuosu" iso639-1="ii" iso639-2T="iii" iso639-2B="iii" iso639-3="iii"/>
            <language name="Occitan" iso639-1="oc" iso639-2T="oci" iso639-2B="oci" iso639-3="oci"/>
            <language name="Ojibwa" iso639-1="oj" iso639-2T="oji" iso639-2B="oji" iso639-3="oji"/>
            <language name="Oriya" iso639-1="or" iso639-2T="ori" iso639-2B="ori" iso639-3="ori"/>
            <language name="Oromo" iso639-1="om" iso639-2T="orm" iso639-2B="orm" iso639-3="orm"/>
            <language name="Ossetian, Ossetic" iso639-1="os" iso639-2T="oss" iso639-2B="oss" iso639-3="oss"/>
            <language name="Pali" iso639-1="pi" iso639-2T="pli" iso639-2B="pli" iso639-3="pli"/>
            <language name="Pashto, Pushto" iso639-1="ps" iso639-2T="pus" iso639-2B="pus" iso639-3="pus"/>
            <language name="Persian" iso639-1="fa" iso639-2T="fas" iso639-2B="per" iso639-3="fas"/>
            <language name="Polish" iso639-1="pl" iso639-2T="pol" iso639-2B="pol" iso639-3="pol"/>
            <language name="Portuguese" iso639-1="pt" iso639-2T="por" iso639-2B="por" iso639-3="por"/>
            <language name="Punjabi, Panjabi" iso639-1="pa" iso639-2T="pan" iso639-2B="pan" iso639-3="pan"/>
            <language name="Quechua" iso639-1="qu" iso639-2T="que" iso639-2B="que" iso639-3="que"/>
            <language name="Romanian, Moldavian, Moldovan" iso639-1="ro" iso639-2T="ron" iso639-2B="rum" iso639-3="ron"/>
            <language name="Romansh" iso639-1="rm" iso639-2T="roh" iso639-2B="roh" iso639-3="roh"/>
            <language name="Rundi" iso639-1="rn" iso639-2T="run" iso639-2B="run" iso639-3="run"/>
            <language name="Russian" iso639-1="ru" iso639-2T="rus" iso639-2B="rus" iso639-3="rus"/>
            <language name="Northern Sami" iso639-1="se" iso639-2T="sme" iso639-2B="sme" iso639-3="sme"/>
            <language name="Samoan" iso639-1="sm" iso639-2T="smo" iso639-2B="smo" iso639-3="smo"/>
            <language name="Sango" iso639-1="sg" iso639-2T="sag" iso639-2B="sag" iso639-3="sag"/>
            <language name="Sanskrit" iso639-1="sa" iso639-2T="san" iso639-2B="san" iso639-3="san"/>
            <language name="Sardinian" iso639-1="sc" iso639-2T="srd" iso639-2B="srd" iso639-3="srd"/>
            <language name="Serbian" iso639-1="sr" iso639-2T="srp" iso639-2B="srp" iso639-3="srp"/>
            <language name="Shona" iso639-1="sn" iso639-2T="sna" iso639-2B="sna" iso639-3="sna"/>
            <language name="Sindhi" iso639-1="sd" iso639-2T="snd" iso639-2B="snd" iso639-3="snd"/>
            <language name="Sinhala, Sinhalese" iso639-1="si" iso639-2T="sin" iso639-2B="sin" iso639-3="sin"/>
            <language name="Slovak" iso639-1="sk" iso639-2T="slk" iso639-2B="slo" iso639-3="slk"/>
            <language name="Slovenian" iso639-1="sl" iso639-2T="slv" iso639-2B="slv" iso639-3="slv"/>
            <language name="Somali" iso639-1="so" iso639-2T="som" iso639-2B="som" iso639-3="som"/>
            <language name="Southern Sotho" iso639-1="st" iso639-2T="sot" iso639-2B="sot" iso639-3="sot"/>
            <language name="Spanish, Castilian" iso639-1="es" iso639-2T="spa" iso639-2B="spa" iso639-3="spa"/>
            <language name="Sundanese" iso639-1="su" iso639-2T="sun" iso639-2B="sun" iso639-3="sun"/>
            <language name="Swahili" iso639-1="sw" iso639-2T="swa" iso639-2B="swa" iso639-3="swa"/>
            <language name="Swati" iso639-1="ss" iso639-2T="ssw" iso639-2B="ssw" iso639-3="ssw"/>
            <language name="Swedish" iso639-1="sv" iso639-2T="swe" iso639-2B="swe" iso639-3="swe"/>
            <language name="Tagalog" iso639-1="tl" iso639-2T="tgl" iso639-2B="tgl" iso639-3="tgl"/>
            <language name="Tahitian" iso639-1="ty" iso639-2T="tah" iso639-2B="tah" iso639-3="tah"/>
            <language name="Tajik" iso639-1="tg" iso639-2T="tgk" iso639-2B="tgk" iso639-3="tgk"/>
            <language name="Tamil" iso639-1="ta" iso639-2T="tam" iso639-2B="tam" iso639-3="tam"/>
            <language name="Tatar" iso639-1="tt" iso639-2T="tat" iso639-2B="tat" iso639-3="tat"/>
            <language name="Telugu" iso639-1="te" iso639-2T="tel" iso639-2B="tel" iso639-3="tel"/>
            <language name="Thai" iso639-1="th" iso639-2T="tha" iso639-2B="tha" iso639-3="tha"/>
            <language name="Tibetan" iso639-1="bo" iso639-2T="bod" iso639-2B="tib" iso639-3="bod"/>
            <language name="Tigrinya" iso639-1="ti" iso639-2T="tir" iso639-2B="tir" iso639-3="tir"/>
            <language name="Tonga (Tonga Islands)" iso639-1="to" iso639-2T="ton" iso639-2B="ton" iso639-3="ton"/>
            <language name="Tsonga" iso639-1="ts" iso639-2T="tso" iso639-2B="tso" iso639-3="tso"/>
            <language name="Tswana" iso639-1="tn" iso639-2T="tsn" iso639-2B="tsn" iso639-3="tsn"/>
            <language name="Turkish" iso639-1="tr" iso639-2T="tur" iso639-2B="tur" iso639-3="tur"/>
            <language name="Turkmen" iso639-1="tk" iso639-2T="tuk" iso639-2B="tuk" iso639-3="tuk"/>
            <language name="Twi" iso639-1="tw" iso639-2T="twi" iso639-2B="twi" iso639-3="twi"/>
            <language name="Uighur, Uyghur" iso639-1="ug" iso639-2T="uig" iso639-2B="uig" iso639-3="uig"/>
            <language name="Ukrainian" iso639-1="uk" iso639-2T="ukr" iso639-2B="ukr" iso639-3="ukr"/>
            <language name="Urdu" iso639-1="ur" iso639-2T="urd" iso639-2B="urd" iso639-3="urd"/>
            <language name="Uzbek" iso639-1="uz" iso639-2T="uzb" iso639-2B="uzb" iso639-3="uzb"/>
            <language name="Venda" iso639-1="ve" iso639-2T="ven" iso639-2B="ven" iso639-3="ven"/>
            <language name="Vietnamese" iso639-1="vi" iso639-2T="vie" iso639-2B="vie" iso639-3="vie"/>
            <language name="Volapük" iso639-1="vo" iso639-2T="vol" iso639-2B="vol" iso639-3="vol"/>
            <language name="Walloon" iso639-1="wa" iso639-2T="wln" iso639-2B="wln" iso639-3="wln"/>
            <language name="Welsh" iso639-1="cy" iso639-2T="cym" iso639-2B="wel" iso639-3="cym"/>
            <language name="Wolof" iso639-1="wo" iso639-2T="wol" iso639-2B="wol" iso639-3="wol"/>
            <language name="Xhosa" iso639-1="xh" iso639-2T="xho" iso639-2B="xho" iso639-3="xho"/>
            <language name="Yiddish" iso639-1="yi" iso639-2T="yid" iso639-2B="yid" iso639-3="yid"/>
            <language name="Yoruba" iso639-1="yo" iso639-2T="yor" iso639-2B="yor" iso639-3="yor"/>
            <language name="Zhuang, Chuang" iso639-1="za" iso639-2T="zha" iso639-2B="zha" iso639-3="zha"/>
            <language name="Zulu" iso639-1="zu" iso639-2T="zul" iso639-2B="zul" iso639-3="zul"/>
        </languages>
    </xsl:variable>
    <!-- Start main page design and layout -->
    <xsl:template match="/">
        <fo:root xmlns:fo="http://www.w3.org/1999/XSL/Format" font-size="12pt" font-family="serif">
            <xsl:attribute name="xml:lang">
                <xsl:value-of select="key('languageCode', /ead:ead/ead:eadheader/ead:profiledesc/ead:langusage/ead:language/@langcode, $languages)/@iso639-1" />
            </xsl:attribute>
            <!-- Set up page types and page layouts -->
            <fo:layout-master-set>
                <!-- Page master for Cover Page -->
                <fo:simple-page-master master-name="cover-page" page-width="8.5in" page-height="11in" margin="0.2in">
                    <fo:region-body margin="0in 0.3in 1in 0.3in"/>
                    <fo:region-before extent="0.2in"/>
                    <fo:region-after extent="3in"/>
                </fo:simple-page-master>
                <!-- Page master for Table of Contents -->
                <fo:simple-page-master master-name="toc" page-width="8.5in" page-height="11in" margin="0.5in">
                    <fo:region-body margin-top="0.25in" margin-bottom="0.25in"/>
                    <fo:region-before extent="0.5in"/>
                    <fo:region-after extent="0.2in"/>
                </fo:simple-page-master>
                <!-- Page master for Finding Aid Contents -->
                <fo:simple-page-master master-name="contents" page-width="8.5in" page-height="11in" margin="0.5in">
                    <fo:region-body margin-top="0.25in" margin-bottom="0.25in"/>
                    <fo:region-before extent="0.5in"/>
                    <fo:region-after extent="0.2in"/>
                </fo:simple-page-master>
            </fo:layout-master-set>
            <!-- Builds PDF bookmarks for all major sections -->
            <xsl:apply-templates select="/ead:ead/ead:archdesc" mode="bookmarks"/>
            <!-- Adds document XMP metadata -->
            <fo:declarations>
                <pdf:catalog xmlns:pdf="http://xmlgraphics.apache.org/fop/extensions/pdf">
                    <!-- this will replace the window title from filename to below dc:title -->
                    <pdf:dictionary type="normal" key="ViewerPreferences">
                        <pdf:boolean key="DisplayDocTitle">true</pdf:boolean>
                    </pdf:dictionary>
                </pdf:catalog>
                <x:xmpmeta xmlns:x="adobe:ns:meta/">
                    <rdf:RDF xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
                        <rdf:Description rdf:about="" xmlns:dc="http://purl.org/dc/elements/1.1/">
                            <dc:title>
                                <xsl:apply-templates select="/ead:ead/ead:eadheader/ead:filedesc/ead:titlestmt/ead:titleproper" mode="coverPage"/>
                            </dc:title>
                        </rdf:Description>
                    </rdf:RDF>
                </x:xmpmeta>
            </fo:declarations>
            <!-- The fo:page-sequence establishes headers, footers and the body of the page.-->
            <!-- Cover page layout -->
            <fo:page-sequence master-reference="cover-page">
                <fo:static-content flow-name="xsl-region-after">
                    <fo:block margin="0 0.3in">
                        <xsl:apply-templates select="/ead:ead/ead:eadheader/ead:filedesc/ead:publicationstmt/ead:publisher" mode="coverPage"/>
                    </fo:block>
                    <xsl:apply-templates select="/ead:ead/ead:eadheader/ead:filedesc/ead:publicationstmt" mode="coverPage"/>
                </fo:static-content>
                <fo:flow flow-name="xsl-region-body">
                    <xsl:apply-templates select="/ead:ead/ead:eadheader/ead:filedesc/ead:titlestmt" mode="coverPage"/>
                </fo:flow>
            </fo:page-sequence>
            <!-- Table of Contents layout -->
            <fo:page-sequence master-reference="toc">
                <!-- Page header -->
                <fo:static-content role="artifact" flow-name="xsl-region-before" margin-top=".15in">
                    <fo:block color="black" font-weight="bold" font-size="16pt" text-align="center">
                        <xsl:apply-templates select="ead:ead/ead:eadheader/ead:filedesc/ead:titlestmt" mode="pageHeader"/>
                    </fo:block>
                </fo:static-content>
                <!-- Page footer-->
                <fo:static-content role="artifact" flow-name="xsl-region-after">
                    <fo:block text-align="center" color="gray">
                        <xsl:text>- Page </xsl:text>
                        <fo:page-number/>
                        <xsl:text> -</xsl:text>
                    </fo:block>
                </fo:static-content>
                <!-- Content of page -->
                <fo:flow flow-name="xsl-region-body">
                    <xsl:apply-templates select="/ead:ead/ead:archdesc" mode="toc"/>
                </fo:flow>
            </fo:page-sequence>
            <!-- All the rest -->
            <fo:page-sequence master-reference="contents">
                <!-- Page header -->
                <fo:static-content role="artifact" flow-name="xsl-region-before" margin-top=".15in">
                    <fo:block color="black" font-weight="normal" font-size="12pt" text-align="left" text-align-last="justify" border-bottom-style="solid">
                        <xsl:value-of select="//ead:eadid"/>
                        <fo:leader leader-pattern="space"/>
                        <xsl:apply-templates select="ead:ead/ead:eadheader/ead:filedesc/ead:titlestmt" mode="pageHeader"/>
                        <fo:leader leader-pattern="space"/>
                        <xsl:text/>
                    </fo:block>
                </fo:static-content>
                <!-- Page footer-->
                <fo:static-content role="artifact" flow-name="xsl-region-after">
                    <fo:block text-align="left" text-align-last="justify" border-top-style="solid">
                        <xsl:apply-templates select="(//ead:repository/ead:corpname)[1]"/>
                        <fo:leader leader-pattern="space"/>
                        <xsl:text/>
                        <fo:leader leader-pattern="space"/>
                        <xsl:text>Page </xsl:text>
                        <fo:page-number/>
                    </fo:block>
                </fo:static-content>
                <!-- Content of page -->
                <fo:flow flow-name="xsl-region-body">
                    <xsl:apply-templates select="/ead:ead/ead:archdesc"/>
                </fo:flow>
            </fo:page-sequence>
        </fo:root>
    </xsl:template>
    <xsl:template name="collectionUrl">
        <xsl:value-of select="//ead:eadid/@url"/>
    </xsl:template>
    <!-- Display Title Notes fields in RAD notes header -->
    <xsl:template name="titleNotes">
        <xsl:if test="ead:odd[starts-with(@type, 'title')]">
            <fo:block xsl:use-attribute-sets="h3ID">Title notes</fo:block>
            <xsl:call-template name="toc"/>
            <fo:block xsl:use-attribute-sets="smp">
                <fo:list-block>
                    <xsl:for-each select="ead:odd[starts-with(@type, 'title')]">
                        <xsl:call-template name="titleNoteListItem"/>
                    </xsl:for-each>
                </fo:list-block>
            </fo:block>
        </xsl:if>
    </xsl:template>
    <xsl:template name="titleNoteListItem">
        <fo:list-item>
            <fo:list-item-label end-indent="label-end()">
                <fo:block>•</fo:block>
            </fo:list-item-label>
            <fo:list-item-body start-indent="body-start()">
                <fo:block>
                    <fo:inline text-decoration="underline" font-weight="bold">
                        <xsl:value-of select="local:titleNoteLabel(.)"/>
                    </fo:inline>: <xsl:value-of select="."/>
                </fo:block>
            </fo:list-item-body>
        </fo:list-item>
    </xsl:template>
    <!-- Named template to link back to the table of contents -->
    <xsl:template name="toc">
        <!-- Uncomment to enable 'back to toc' links on each section.
        <fo:block font-size="11pt" margin-top="12pt" margin-bottom="18pt">
            <fo:basic-link text-decoration="none" internal-destination="toc" color="#14A6DC">
            <fo:inline font-weight="bold">^</fo:inline> Return to Table of Contents </fo:basic-link>
        </fo:block>
        -->
    </xsl:template>
    <!-- Cover page templates -->
    <!-- Builds title -->
    <xsl:template match="ead:titlestmt" mode="pageHeader">
        <xsl:apply-templates select="ead:titleproper[1]"/>
    </xsl:template>
    <xsl:template match="ead:titlestmt" mode="coverPage">
        <!-- Calls template with links to archive logo -->
        <fo:block border-bottom="1pt solid #666" margin-top="1.5cm" id="cover-page">
            <xsl:call-template name="logo"/>
            <fo:block role="H1" xsl:use-attribute-sets="h1">
                Finding Aid -
                <xsl:apply-templates select="ead:titleproper[1]"/>
                (<xsl:value-of select="//ead:eadid"/>)
                <xsl:if test="ead:subtitle">
                    <fo:block font-size="16" font-weight="bold">
                        <xsl:apply-templates select="ead:subtitle"/>
                    </fo:block>
                </xsl:if>
            </fo:block>
        </fo:block>
        <fo:block margin-top="8pt">
            <xsl:apply-templates select="/ead:ead/ead:eadheader/ead:profiledesc"/>
        </fo:block>
        <fo:block margin-top="8pt">
            <xsl:apply-templates select="/ead:ead/ead:eadheader/ead:filedesc/ead:editionstmt"/>
        </fo:block>
    </xsl:template>
    <xsl:template match="ead:publicationstmt" mode="coverPage">
        <fo:block margin="0 0.3in">
            <xsl:apply-templates select="ead:address"/>
            <xsl:value-of select="//ead:eadid/@url"/>
        </fo:block>
    </xsl:template>
    <xsl:template match="ead:profiledesc/child::*">
        <fo:block>
            <xsl:apply-templates/>
        </fo:block>
    </xsl:template>
    <xsl:template match="ead:profiledesc/ead:descrules"/>
    <xsl:template match="ead:profiledesc/ead:language">
        <xsl:value-of select="."/>
    </xsl:template>
    <xsl:template match="ead:profiledesc/ead:creation">
        Generated by <xsl:apply-templates select="/ead:ead/ead:eadheader/ead:filedesc/ead:publicationstmt/ead:publisher" mode="coverPage"/> on <xsl:apply-templates select="ead:date"/>
    </xsl:template>
    <xsl:template match="ead:profiledesc/ead:creation/ead:date">
        <!--
            Uses local function to format date into Month, day year.
            To print date as seen in xml change to select="."
        -->
        <xsl:apply-templates select="local:parseDate(.)"/>
    </xsl:template>
    <!-- Generates PDF Bookmarks -->
    <xsl:template match="ead:archdesc" mode="bookmarks">
        <fo:bookmark-tree>
            <fo:bookmark internal-destination="cover-page">
                <fo:bookmark-title>Title Page</fo:bookmark-title>
            </fo:bookmark>
            <xsl:if test="ead:did">
                <fo:bookmark internal-destination="{local:buildID(ead:did)}">
                    <fo:bookmark-title>
                        <xsl:value-of select="local:tagName(ead:did)"/>
                    </fo:bookmark-title>
                </fo:bookmark>
            </xsl:if>
            <xsl:if test="ead:bioghist">
                <fo:bookmark internal-destination="{local:buildID(ead:bioghist[1])}">
                    <fo:bookmark-title>
                        <xsl:value-of select="local:tagName(ead:bioghist[1])"/>
                    </fo:bookmark-title>
                </fo:bookmark>
            </xsl:if>
            <xsl:if test="ead:scopecontent">
                <fo:bookmark internal-destination="{local:buildID(ead:scopecontent[1])}">
                    <fo:bookmark-title>
                        <xsl:value-of select="local:tagName(ead:scopecontent[1])"/>
                    </fo:bookmark-title>
                </fo:bookmark>
            </xsl:if>
            <xsl:if test="ead:fileplan">
                <fo:bookmark internal-destination="{local:buildID(ead:fileplan[1])}">
                    <fo:bookmark-title>
                        <xsl:value-of select="local:tagName(ead:fileplan[1])"/>
                    </fo:bookmark-title>
                </fo:bookmark>
            </xsl:if>
            <!-- Administrative Information -->
            <xsl:if test="ead:accessrestrict or ead:userestrict or ead:custodhist or ead:accruals or ead:altformavail or ead:acqinfo or ead:processinfo or ead:appraisal or ead:originalsloc or /ead:ead/ead:eadheader/ead:filedesc/ead:publicationstmt or /ead:ead/ead:eadheader/ead:revisiondesc">
                <fo:bookmark internal-destination="adminInfo">
                    <fo:bookmark-title>Notes</fo:bookmark-title>
                </fo:bookmark>
            </xsl:if>
            <xsl:if test="ead:phystech">
                <fo:bookmark internal-destination="{local:buildID(ead:phystech[1])}">
                    <fo:bookmark-title>
                        <xsl:value-of select="local:tagName(ead:phystech[1])"/>
                    </fo:bookmark-title>
                </fo:bookmark>
            </xsl:if>
            <xsl:if test="ead:controlaccess">
                <fo:bookmark internal-destination="{local:buildID(ead:controlaccess[1])}">
                    <fo:bookmark-title>
                        <xsl:value-of select="local:tagName(ead:controlaccess[1])"/>
                    </fo:bookmark-title>
                </fo:bookmark>
            </xsl:if>
            <xsl:if test="ead:bibliography">
                <fo:bookmark internal-destination="{local:buildID(ead:bibliography[1])}">
                    <fo:bookmark-title>
                        <xsl:value-of select="local:tagName(ead:bibliography[1])"/>
                    </fo:bookmark-title>
                </fo:bookmark>
            </xsl:if>
            <xsl:if test="ead:index">
                <fo:bookmark internal-destination="{local:buildID(ead:index[1])}">
                    <fo:bookmark-title>
                        <xsl:value-of select="local:tagName(ead:index[1])"/>
                    </fo:bookmark-title>
                </fo:bookmark>
            </xsl:if>
            <!-- Get c-level bookmarks -->
            <xsl:apply-templates select="ead:dsc" mode="bookmarks"/>
        </fo:bookmark-tree>
    </xsl:template>
    <!-- Table of Contents -->
    <xsl:template match="ead:archdesc" mode="toc">
        <fo:block line-height="18pt" margin-top="0.25in">
            <fo:block role="H2" xsl:use-attribute-sets="h2" id="toc">Table of contents</fo:block>
            <fo:block xsl:use-attribute-sets="section">
                <xsl:if test="ead:did">
                    <fo:block text-align-last="justify">
                        <fo:basic-link internal-destination="{local:buildID(ead:did)}">
                            <xsl:value-of select="local:tagName(ead:did)"/>
                        </fo:basic-link>
                        <xsl:text>  </xsl:text>
                        <fo:leader leader-pattern="dots"/>
                        <xsl:text>  </xsl:text>
                        <fo:page-number-citation ref-id="{local:buildID(ead:did)}"/>
                    </fo:block>
                </xsl:if>
                <xsl:if test="ead:bioghist">
                    <fo:block text-align-last="justify">
                        <fo:basic-link internal-destination="{local:buildID(ead:bioghist[1])}">
                            <xsl:value-of select="local:tagName(ead:bioghist[1])"/>
                        </fo:basic-link>
                        <xsl:text>  </xsl:text>
                        <fo:leader leader-pattern="dots"/>
                        <xsl:text>  </xsl:text>
                        <fo:page-number-citation ref-id="{local:buildID(ead:bioghist[1])}"/>
                    </fo:block>
                </xsl:if>
                <xsl:if test="ead:scopecontent">
                    <fo:block text-align-last="justify">
                        <fo:basic-link internal-destination="{local:buildID(ead:scopecontent[1])}">
                            <xsl:value-of select="local:tagName(ead:scopecontent[1])"/>
                        </fo:basic-link>
                        <xsl:text>  </xsl:text>
                        <fo:leader leader-pattern="dots"/>
                        <xsl:text>  </xsl:text>
                        <fo:page-number-citation ref-id="{local:buildID(ead:scopecontent[1])}"/>
                    </fo:block>
                </xsl:if>
                <xsl:if test="ead:fileplan">
                    <fo:block text-align-last="justify">
                        <fo:basic-link internal-destination="{local:buildID(ead:fileplan[1])}">
                            <xsl:value-of select="local:tagName(ead:fileplan[1])"/>
                        </fo:basic-link>
                        <xsl:text>  </xsl:text>
                        <fo:leader leader-pattern="dots"/>
                        <xsl:text>  </xsl:text>
                        <fo:page-number-citation ref-id="{local:buildID(ead:fileplan[1])}"/>
                    </fo:block>
                </xsl:if>
                <!-- NOTES HEADING -->
                <xsl:if test="ead:accessrestrict | ead:userestrict | ead:custodhist | ead:accruals | ead:altformavail | ead:acqinfo | ead:processinfo | ead:appraisal | ead:originalsloc | /ead:ead/ead:eadheader/ead:revisiondesc">
                    <fo:block text-align-last="justify">
                        <fo:basic-link internal-destination="adminInfo">Notes</fo:basic-link>
                        <xsl:text>  </xsl:text>
                        <fo:leader leader-pattern="dots"/>
                        <xsl:text>  </xsl:text>
                        <fo:page-number-citation ref-id="adminInfo"/>
                    </fo:block>
                </xsl:if>
                <xsl:if test="ead:controlaccess">
                    <fo:block text-align-last="justify">
                        <fo:basic-link internal-destination="{local:buildID(ead:controlaccess[1])}">
                            <xsl:value-of select="local:tagName(ead:controlaccess[1])"/>
                        </fo:basic-link>
                        <xsl:text>  </xsl:text>
                        <fo:leader leader-pattern="dots"/>
                        <xsl:text>  </xsl:text>
                        <fo:page-number-citation ref-id="{local:buildID(ead:controlaccess[1])}"/>
                    </fo:block>
                </xsl:if>
                <xsl:if test="ead:phystech">
                    <fo:block text-align-last="justify">
                        <fo:basic-link internal-destination="{local:buildID(ead:phystech[1])}">
                            <xsl:value-of select="local:tagName(ead:phystech[1])"/>
                        </fo:basic-link>
                        <xsl:text>  </xsl:text>
                        <fo:leader leader-pattern="dots"/>
                        <xsl:text>  </xsl:text>
                        <fo:page-number-citation ref-id="{local:buildID(ead:phystech[1])}"/>
                    </fo:block>
                </xsl:if>
                <xsl:if test="ead:bibliography">
                    <fo:block text-align-last="justify">
                        <fo:basic-link internal-destination="{local:buildID(ead:bibliography[1])}">
                            <xsl:value-of select="local:tagName(ead:bibliography[1])"/>
                        </fo:basic-link>
                        <xsl:text>  </xsl:text>
                        <fo:leader leader-pattern="dots"/>
                        <xsl:text>  </xsl:text>
                        <fo:page-number-citation ref-id="{local:buildID(ead:bibliography[1])}"/>
                    </fo:block>
                </xsl:if>
                <xsl:if test="ead:index">
                    <fo:block text-align-last="justify">
                        <fo:basic-link internal-destination="{local:buildID(ead:index[1])}">
                            <xsl:value-of select="local:tagName(ead:index[1])"/>
                        </fo:basic-link>
                        <xsl:text>  </xsl:text>
                        <fo:leader leader-pattern="dots"/>
                        <xsl:text>  </xsl:text>
                        <fo:page-number-citation ref-id="{local:buildID(ead:index[1])}"/>
                    </fo:block>
                </xsl:if>
                <!-- Get c-level menu and submenu -->
                <xsl:apply-templates select="ead:dsc" mode="toc"/>
            </fo:block>
        </fo:block>
    </xsl:template>
    <!--
        Formats children of archdesc. This template orders the children of the archdesc,
        if order is changed it must also be changed in the table of contents.
    -->
    <xsl:template match="ead:archdesc">
        <xsl:apply-templates select="ead:did"/>
        <xsl:apply-templates select="ead:bioghist"/>
        <xsl:apply-templates select="ead:custodhist"/>
        <xsl:apply-templates select="ead:scopecontent"/>
        <xsl:apply-templates select="ead:fileplan"/>
        <!-- NOTES SECTION -->
        <xsl:if test="ead:accessrestrict | ead:userestrict | ead:custodhist | ead:accruals | ead:did/ead:note | ead:altformavail | ead:acqinfo | ead:processinfo | ead:appraisal | ead:originalsloc | /ead:ead/ead:eadheader/ead:filedesc/ead:publicationstmt | /ead:ead/ead:eadheader/ead:revisiondesc">
            <fo:block xsl:use-attribute-sets="section">
                <fo:block role="H2" xsl:use-attribute-sets="h2" id="adminInfo">Notes</fo:block>
                <!-- Try to handle EAD tags in RAD order... -->
                <xsl:call-template name="titleNotes"/>
                <xsl:apply-templates select="ead:phystech"/>
                <xsl:apply-templates select="ead:acqinfo"/>
                <xsl:apply-templates select="ead:arrangement"/>
                <xsl:apply-templates select="ead:originalsloc"/>
                <xsl:apply-templates select="ead:altformavail"/>
                <xsl:apply-templates select="ead:accessrestrict"/>
                <xsl:apply-templates select="ead:userestrict"/>
                <xsl:apply-templates select="ead:otherfindaid"/>
                <xsl:apply-templates select="ead:relatedmaterial"/>
                <xsl:apply-templates select="ead:accruals"/>
                <xsl:apply-templates select="ead:did/ead:note"/>
                <xsl:call-template name="otherNotes"/>
                <xsl:call-template name="toc"/>
            </fo:block>
        </xsl:if>
        <xsl:apply-templates select="ead:controlaccess"/>
        <xsl:apply-templates select="ead:bibliography"/>
        <xsl:apply-templates select="ead:dsc"/>
    </xsl:template>
    <!-- Formats archdesc did -->
    <xsl:template match="ead:archdesc/ead:did">
        <fo:block xsl:use-attribute-sets="section">
            <fo:block role="H2" xsl:use-attribute-sets="h2ID">Summary information</fo:block>
            <!--
                Determines the order in which elements from the archdesc did appear,
                to change the order of appearance change the order of the following
                apply-template statements.
            -->
            <fo:table table-layout="fixed" width="100%">
                <fo:table-column column-width="2in"/>
                <fo:table-column column-width="5in"/>
                <fo:table-body>
                    <xsl:call-template name="summaryInfoOtherField">
                        <xsl:with-param name="path" select="//ead:repository/ead:corpname"/>
                        <xsl:with-param name="label" select="'Repository'"/>
                    </xsl:call-template>
                    <xsl:apply-templates select="//ead:archdesc/ead:origination" mode="overview"/>
                    <xsl:apply-templates select="ead:unittitle" mode="overview"/>
                    <xsl:apply-templates select="ead:unitid" mode="overview"/>
                    <xsl:apply-templates select="ead:unitdate" mode="overview"/>
                    <xsl:apply-templates select="ead:physdesc" mode="overview"/>
                    <xsl:apply-templates select="ead:container" mode="overview"/>
                    <xsl:apply-templates select="ead:langmaterial/ead:language" mode="overview"/>
                    <xsl:call-template name="summaryInfoOtherField">
                        <xsl:with-param name="path" select="//ead:processinfo/ead:p/ead:date"/>
                        <xsl:with-param name="label" select="'Dates of creation, revision and deletion'"/>
                    </xsl:call-template>
                </fo:table-body>
            </fo:table>
            <!-- Link back to table of contents -->
            <xsl:call-template name="toc"/>
        </fo:block>
    </xsl:template>
    <!-- Formats children of arcdesc/did -->
    <xsl:template match="ead:repository | ead:origination | ead:unittitle | ead:unitdate | ead:unitid | ead:physdesc | ead:container | ead:dao | ead:daogrp | ead:langmaterial | ead:materialspec | ead:abstract | ead:note | ead:langmaterial/ead:language" mode="overview">
        <fo:table-row>
            <fo:table-cell padding-bottom="8pt" padding-right="16pt" text-align="right" font-weight="bold">
                <fo:block>
                    <xsl:apply-templates select="." mode="fieldLabel"/>:
                </fo:block>
            </fo:table-cell>
            <fo:table-cell padding-bottom="2pt">
                <fo:block>
                    <xsl:apply-templates select="." mode="fieldValue"/>
                </fo:block>
            </fo:table-cell>
        </fo:table-row>
    </xsl:template>
    <xsl:template name="summaryInfoOtherField">
        <xsl:param name="path"/>
        <xsl:param name="label"/>
        <xsl:if test="$path">
            <fo:table-row>
                <fo:table-cell padding-bottom="8pt" padding-right="16pt" text-align="right" font-weight="bold">
                    <fo:block>
                        <xsl:value-of select="$label"/>:
                    </fo:block>
                </fo:table-cell>
                <fo:table-cell padding-bottom="2pt">
                    <fo:block>
                        <xsl:value-of select="($path)[1]"/>
                    </fo:block>
                </fo:table-cell>
            </fo:table-row>
        </xsl:if>
    </xsl:template>
    <!-- Formats the 'other' notes headings -->
    <xsl:template name="otherNotes">
        <xsl:if test="ead:odd">
            <fo:block role="H3" xsl:use-attribute-sets="h3ID">Other notes</fo:block>
            <fo:list-block xsl:use-attribute-sets="section">
                <xsl:for-each select="ead:odd">
                    <xsl:variable name="label" select="local:oddLabel(.)"/>
                    <xsl:if test="string-length($label) > 0">
                        <fo:list-item>
                            <fo:list-item-label end-indent="label-end()">
                                <fo:block>•</fo:block>
                            </fo:list-item-label>
                            <fo:list-item-body start-indent="body-start()">
                                <fo:block>
                                    <!-- We have other <odd> elements used
                                    elsewhere, such as title notes. Only print
                                    the <odd> elements we've *handled* here in
                                    this section. -->
                                    <fo:inline text-decoration="underline" font-weight="bold">
                                        <xsl:value-of select="$label"/>
                                    </fo:inline>
                                    <xsl:text>: </xsl:text>
                                    <xsl:value-of select="."/>
                                </fo:block>
                            </fo:list-item-body>
                        </fo:list-item>
                    </xsl:if>
                </xsl:for-each>
            </fo:list-block>
        </xsl:if>
    </xsl:template>
    <xsl:template name="otherNotesSeries">
        <xsl:if test="following-sibling::ead:odd">
            <xsl:for-each select="following-sibling::ead:odd">
                <xsl:variable name="label" select="local:oddLabel(.)"/>
                <xsl:if test="string-length($label) > 0">
                    <fo:block font-size="12" padding="2" margin="2">
                        <!-- We have other <odd> elements used elsewhere, such
                        as title notes. only print the <odd> elements we've
                        *handled* here in this section. -->
                        <fo:inline text-decoration="underline" margin="2">
                            <xsl:value-of select="$label"/>
                        </fo:inline>
                        <xsl:text>: </xsl:text>
                        <fo:block/>
                        <fo:block margin="4" padding="4">
                            <xsl:value-of select="."/>
                        </fo:block>
                    </fo:block>
                </xsl:if>
            </xsl:for-each>
        </xsl:if>
    </xsl:template>
    <!-- Adds space between extents -->
    <xsl:template match="ead:extent"><xsl:apply-templates/> </xsl:template>
    <!-- Formats children of arcdesc not in administrative or related materials sections-->
    <xsl:template match="ead:bibliography | ead:odd | ead:bioghist | ead:scopecontent | ead:fileplan">
        <fo:block xsl:use-attribute-sets="section">
            <fo:block role="H2" xsl:use-attribute-sets="h2ID">
                <xsl:value-of select="local:tagName(.)"/>
            </fo:block>
            <xsl:apply-templates/>
            <xsl:call-template name="toc"/>
        </fo:block>
    </xsl:template>
    <!-- Formats children of arcdesc in administrative and related materials sections -->
    <xsl:template match="ead:relatedmaterial | ead:separatedmaterial | ead:accessrestrict | ead:userestrict | ead:custodhist | ead:accruals | ead:note | ead:notestmt | ead:altformavail | ead:acqinfo | ead:processinfo | ead:appraisal | ead:originalsloc | ead:phystech | ead:arrangement | ead:otherfindaid">
        <fo:block role="H3" xsl:use-attribute-sets="h3ID">
            <xsl:apply-templates select="." mode="fieldLabel"/>
        </fo:block>
        <fo:block xsl:use-attribute-sets="section">
            <xsl:apply-templates select="." mode="fieldValue"/>
        </fo:block>
    </xsl:template>
    <!-- Publication statement included in administrative information section -->
    <xsl:template match="ead:publicationstmt"/>
    <!-- Formats Address elements -->
    <xsl:template match="ead:address">
        <fo:block>
            <xsl:apply-templates/>
        </fo:block>
    </xsl:template>
    <xsl:template match="ead:addressline">
        <xsl:choose>
            <xsl:when test="contains(.,'@')">
                <fo:block>
                    <fo:basic-link external-destination="url('mailto:{.}')" xsl:use-attribute-sets="ref">
                        <xsl:value-of select="."/>
                    </fo:basic-link>
                </fo:block>
            </xsl:when>
            <xsl:otherwise>
                <fo:block>
                    <xsl:apply-templates/>
                </fo:block>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <!-- Templates for revision description -->
    <xsl:template match="ead:revisiondesc">
        <fo:block xsl:use-attribute-sets="section">
            <fo:block role="H3" xsl:use-attribute-sets="h3ID">
                <xsl:value-of select="local:tagName(.)"/>
            </fo:block>
            <xsl:if test="ead:change/ead:item">
                <xsl:value-of select="ead:change/ead:item"/>
            </xsl:if>
            <xsl:if test="ead:change/ead:date"> <xsl:value-of select="ead:change/ead:date"/></xsl:if>
        </fo:block>
    </xsl:template>
    <!-- Formats controlled access terms -->
    <xsl:template match="ead:controlaccess">
        <xsl:if test="child::*">
            <fo:block xsl:use-attribute-sets="section">
                <fo:block role="H2" xsl:use-attribute-sets="h2ID">
                    <xsl:value-of select="local:tagName(.)"/>
                </fo:block>
                <fo:list-block xsl:use-attribute-sets="smp">
                    <xsl:apply-templates/>
                </fo:list-block>
            </fo:block>
        </xsl:if>
    </xsl:template>
    <xsl:template match="ead:controlaccess/child::*">
        <fo:list-item>
            <fo:list-item-label end-indent="label-end()">
                <fo:block>•</fo:block>
            </fo:list-item-label>
            <fo:list-item-body start-indent="body-start()">
                <fo:block>
                    <xsl:value-of select="."/>
                    <!-- Present the type of access point after the value in parentheses -->
                    <xsl:if test="name()='genreform'"> (documentary form)</xsl:if>
                    <xsl:if test="name()='subject'"> (subject)</xsl:if>
                    <xsl:if test="name()='geogname'"> (place)</xsl:if>
                    <xsl:if test="name()='name' or name()='persname'">
                        <xsl:if test="current()[@role='Creator']"> (creator)</xsl:if>
                        <xsl:if test="current()[@role='subject']"> (subject)</xsl:if>
                    </xsl:if>
                </fo:block>
            </fo:list-item-body>
        </fo:list-item>
    </xsl:template>
    <!-- Formats index and child elements, groups indexentry elements by type (i.e. corpname, subject...) -->
    <xsl:template match="ead:index">
        <fo:block xsl:use-attribute-sets="section">
            <fo:block role="H2" xsl:use-attribute-sets="h2ID">
                <xsl:value-of select="local:tagName(.)"/>
            </fo:block>
            <xsl:apply-templates select="child::*[not(self::ead:indexentry)]"/>
            <fo:list-block xsl:use-attribute-sets="smp">
                <xsl:apply-templates select="ead:indexentry"/>
            </fo:list-block>
        </fo:block>
    </xsl:template>
    <xsl:template match="ead:indexentry">
        <fo:list-item>
            <fo:list-item-label end-indent="label-end()">
                <fo:block>•</fo:block>
            </fo:list-item-label>
            <fo:list-item-body start-indent="body-start()">
                <fo:block>
                    <xsl:apply-templates/>
                </fo:block>
            </fo:list-item-body>
        </fo:list-item>
    </xsl:template>
    <!-- Formats a simple table. The width of each column is defined by the colwidth attribute in a colspec element. -->
    <xsl:template match="ead:table">
        <xsl:apply-templates/>
    </xsl:template>
    <xsl:template match="ead:table/ead:thead">
        <fo:block role="H4" xsl:use-attribute-sets="h4ID">
            <xsl:apply-templates/>
        </fo:block>
    </xsl:template>
    <xsl:template match="ead:tgroup">
        <fo:table xsl:use-attribute-sets="tableBorder">
            <xsl:apply-templates/>
            <fo:table-body>
                <xsl:apply-templates select="*[not(ead:colspec)]"/>
            </fo:table-body>
        </fo:table>
    </xsl:template>
    <xsl:template match="ead:colspec">
        <fo:table-column column-width="{@colwidth}"/>
    </xsl:template>
    <xsl:template match="ead:thead">
        <xsl:apply-templates mode="thead"/>
    </xsl:template>
    <xsl:template match="ead:tbody">
        <fo:table-body>
            <xsl:apply-templates/>
        </fo:table-body>
    </xsl:template>
    <xsl:template match="ead:row" mode="thead">
        <fo:table-row xsl:use-attribute-sets="th">
            <xsl:apply-templates/>
        </fo:table-row>
    </xsl:template>
    <xsl:template match="ead:row">
        <fo:table-row>
            <xsl:apply-templates/>
        </fo:table-row>
    </xsl:template>
    <xsl:template match="ead:entry">
        <fo:table-cell xsl:use-attribute-sets="tdBorder">
            <fo:block xsl:use-attribute-sets="smp">
                <xsl:apply-templates/>
            </fo:block>
        </fo:table-cell>
    </xsl:template>
    <!--Bibref citation inline, if there is a parent element.-->
    <xsl:template match="ead:p/ead:bibref">
        <xsl:choose>
            <xsl:when test="@*:href">
                <fo:basic-link external-destination="url('{@*:href}')" xsl:use-attribute-sets="ref">
                    <xsl:apply-templates/>
                </fo:basic-link>
            </xsl:when>
            <xsl:otherwise>
                <xsl:apply-templates/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <!--Bibref citation on its own line, typically when it is a child of the bibliography element-->
    <xsl:template match="ead:bibref">
        <fo:block>
            <xsl:choose>
                <xsl:when test="@*:href">
                    <fo:basic-link external-destination="url('{@*:href}')" xsl:use-attribute-sets="ref">
                        <xsl:apply-templates/>
                    </fo:basic-link>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:apply-templates/>
                </xsl:otherwise>
            </xsl:choose>
        </fo:block>
    </xsl:template>
    <!-- Lists -->
    <!-- Lists with listhead element are output as tables -->
    <xsl:template match="ead:list[ead:listhead]">
        <xsl:apply-templates select="ead:head"/>
        <fo:table xsl:use-attribute-sets="tableBorder">
            <fo:table-body>
                <fo:table-row xsl:use-attribute-sets="th">
                    <fo:table-cell xsl:use-attribute-sets="tdBorder">
                        <fo:block xsl:use-attribute-sets="smp">
                            <xsl:value-of select="ead:listhead/ead:head01"/>
                        </fo:block>
                    </fo:table-cell>
                    <fo:table-cell xsl:use-attribute-sets="tdBorder">
                        <fo:block>
                            <xsl:value-of select="ead:listhead/ead:head02"/>
                        </fo:block>
                    </fo:table-cell>
                </fo:table-row>
                <xsl:apply-templates select="ead:defitem" mode="listTable"/>
            </fo:table-body>
        </fo:table>
    </xsl:template>
    <!-- Formats ordered and definition lists -->
    <xsl:template match="ead:list">
        <xsl:apply-templates select="ead:head"/>
        <fo:list-block xsl:use-attribute-sets="smp">
            <xsl:choose>
                <xsl:when test="@type='deflist'">
                    <xsl:apply-templates select="ead:defitem"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:apply-templates select="ead:item"/>
                </xsl:otherwise>
            </xsl:choose>
        </fo:list-block>
    </xsl:template>
    <xsl:template match="ead:item">
        <fo:list-item>
            <fo:list-item-label end-indent="label-end()">
                <fo:block>
                    <xsl:choose>
                        <xsl:when test="../@type='ordered' and ../@numeration = 'arabic'">
                            <xsl:number format="1"/>
                        </xsl:when>
                        <xsl:when test="../@type='ordered' and ../@numeration = 'upperalpha'">
                            <xsl:number format="A"/>
                        </xsl:when>
                        <xsl:when test="../@type='ordered' and ../@numeration = 'loweralpha'">
                            <xsl:number format="a"/>
                        </xsl:when>
                        <xsl:when test="../@type='ordered' and ../@numeration = 'upperroman'">
                            <xsl:number format="I"/>
                        </xsl:when>
                        <xsl:when test="../@type='ordered' and ../@numeration = 'upperalpha'">
                            <xsl:number format="i"/>
                        </xsl:when>
                        <xsl:when test="../@type='ordered' and not(../@numeration)">
                            <xsl:number format="1"/>
                        </xsl:when>
                        <xsl:otherwise>•</xsl:otherwise>
                    </xsl:choose>
                </fo:block>
            </fo:list-item-label>
            <fo:list-item-body start-indent="body-start()">
                <fo:block>
                    <xsl:apply-templates/>
                </fo:block>
            </fo:list-item-body>
        </fo:list-item>
    </xsl:template>
    <xsl:template match="ead:defitem">
        <fo:list-item>
            <fo:list-item-label end-indent="label-end()">
                <fo:block/>
            </fo:list-item-label>
            <fo:list-item-body start-indent="body-start()">
                <fo:block font-weight="bold">
                    <xsl:apply-templates select="ead:label"/>
                </fo:block>
                <fo:block margin-left="18pt">
                    <xsl:apply-templates select="ead:item" mode="deflist"/>
                </fo:block>
            </fo:list-item-body>
        </fo:list-item>
    </xsl:template>
    <!-- Formats list as table if list has listhead element -->
    <xsl:template match="ead:defitem" mode="listTable">
        <fo:table-row>
            <fo:table-cell xsl:use-attribute-sets="tdBorder">
                <fo:block xsl:use-attribute-sets="smp">
                    <xsl:apply-templates select="ead:label"/>
                </fo:block>
            </fo:table-cell>
            <fo:table-cell xsl:use-attribute-sets="tdBorder">
                <fo:block xsl:use-attribute-sets="smp">
                    <xsl:apply-templates select="ead:item"/>
                </fo:block>
            </fo:table-cell>
        </fo:table-row>
    </xsl:template>
    <!-- Output chronlist and children in a table -->
    <xsl:template match="ead:chronlist">
        <xsl:apply-templates/>
    </xsl:template>
    <xsl:template match="ead:chronitem">
        <fo:block linefeed-treatment="preserve">
            <xsl:apply-templates select="descendant::ead:note"/>
            <xsl:value-of select="text()"/>
        </fo:block>
    </xsl:template>
    <!-- Formats legalstatus -->
    <xsl:template match="ead:legalstatus">
        <fo:block xsl:use-attribute-sets="smp">
            <fo:inline font-weight="bold"><xsl:value-of select="local:tagName(.)"/>: </fo:inline>
            <xsl:apply-templates/>
        </fo:block>
    </xsl:template>
    <!-- General headings -->
    <!-- Children of the archdesc are handled by the local:tagName function -->
    <xsl:template match="ead:head[parent::*/parent::ead:archdesc]"/>
    <!-- All other headings -->
    <xsl:template match="ead:head">
        <fo:block role="H4" xsl:use-attribute-sets="h4" id="{local:buildID(parent::*)}">
            <xsl:apply-templates/>
        </fo:block>
    </xsl:template>
    <!-- Linking elmenets -->
    <xsl:template match="ead:ref">
        <fo:basic-link internal-destination="{@target}" xsl:use-attribute-sets="ref">
            <xsl:choose>
                <xsl:when test="text()">
                    <xsl:value-of select="."/>
                </xsl:when>
                <xsl:when test="@*:title">
                    <xsl:value-of select="@*:title"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="@target"/>
                </xsl:otherwise>
            </xsl:choose>
        </fo:basic-link>
    </xsl:template>
    <xsl:template match="ead:ptr">
        <fo:basic-link external-destination="url('{@target}')" xsl:use-attribute-sets="ref">
            <xsl:choose>
                <xsl:when test="child::*">
                    <xsl:value-of select="."/>
                </xsl:when>
                <xsl:when test="@*:title">
                    <xsl:value-of select="@*:title"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="@target"/>
                </xsl:otherwise>
            </xsl:choose>
        </fo:basic-link>
    </xsl:template>
    <xsl:template match="ead:extref">
        <fo:basic-link external-destination="url('{@*:href}')" xsl:use-attribute-sets="ref">
            <xsl:choose>
                <xsl:when test="text()">
                    <xsl:value-of select="."/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="@*:href"/>
                </xsl:otherwise>
            </xsl:choose>
        </fo:basic-link>
    </xsl:template>
    <xsl:template match="ead:extrefloc">
        <fo:basic-link external-destination="url('{@*:href}')" xsl:use-attribute-sets="ref">
            <xsl:choose>
                <xsl:when test="text()">
                    <xsl:value-of select="."/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="@*:href"/>
                </xsl:otherwise>
            </xsl:choose>
        </fo:basic-link>
    </xsl:template>
    <xsl:template match="ead:extptr[@*:entityref]">
        <fo:basic-link external-destination="url('{@*:entityref}')" xsl:use-attribute-sets="ref">
            <xsl:choose>
                <xsl:when test="@*:title">
                    <xsl:value-of select="@*:title"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="@*:entityref"/>
                </xsl:otherwise>
            </xsl:choose>
        </fo:basic-link>
    </xsl:template>
    <xsl:template match="ead:extptr[@*:href]">
        <fo:basic-link external-destination="url('{@*:href}')" xsl:use-attribute-sets="ref">
            <xsl:choose>
                <xsl:when test="@*:title">
                    <xsl:value-of select="@*:title"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="@*:href"/>
                </xsl:otherwise>
            </xsl:choose>
        </fo:basic-link>
    </xsl:template>
    <xsl:template match="ead:dao">
        <xsl:variable name="linkTitle">
            <xsl:choose>
                <xsl:when test="child::*">
                    <xsl:apply-templates/>
                </xsl:when>
                <xsl:when test="@*:title">
                    <xsl:value-of select="@*:title"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="@*:href"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <fo:basic-link external-destination="url('{@*:href}')" xsl:use-attribute-sets="ref">
            <xsl:value-of select="$linkTitle"/>
        </fo:basic-link>
    </xsl:template>
    <xsl:template match="ead:daogrp">
        <fo:block>
            <xsl:apply-templates/>
        </fo:block>
    </xsl:template>
    <xsl:template match="ead:daoloc">
        <fo:basic-link external-destination="url('{@*:href}')" xsl:use-attribute-sets="ref">
            <xsl:choose>
                <xsl:when test="text()">
                    <xsl:value-of select="."/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="@*:href"/>
                </xsl:otherwise>
            </xsl:choose>
        </fo:basic-link>
    </xsl:template>
    <!--Render elements -->
    <xsl:template match="*[@render = 'bold'] | *[@altrender = 'bold'] ">
        <fo:inline font-weight="bold">
            <xsl:if test="preceding-sibling::*">  </xsl:if>
            <xsl:apply-templates/>
        </fo:inline>
    </xsl:template>
    <xsl:template match="*[@render = 'bolddoublequote'] | *[@altrender = 'bolddoublequote']">
        <fo:inline font-weight="bold">
            <xsl:if test="preceding-sibling::*">  </xsl:if>
            "<xsl:apply-templates/>"
        </fo:inline>
    </xsl:template>
    <xsl:template match="*[@render = 'boldsinglequote'] | *[@altrender = 'boldsinglequote']">
        <fo:inline font-weight="bold">
            <xsl:if test="preceding-sibling::*">  </xsl:if>
            '<xsl:apply-templates/>'
        </fo:inline>
    </xsl:template>
    <xsl:template match="*[@render = 'bolditalic'] | *[@altrender = 'bolditalic']">
        <fo:inline font-weight="bold" font-style="italic">
            <xsl:if test="preceding-sibling::*">  </xsl:if>
            <xsl:apply-templates/>
        </fo:inline>
    </xsl:template>
    <xsl:template match="*[@render = 'boldsmcaps'] | *[@altrender = 'boldsmcaps']">
        <fo:inline font-weight="bold" font-variant="small-caps">
            <xsl:if test="preceding-sibling::*">  </xsl:if>
            <xsl:apply-templates/>
        </fo:inline>
    </xsl:template>
    <xsl:template match="*[@render = 'boldunderline'] | *[@altrender = 'boldunderline']">
        <fo:inline font-weight="bold" border-bottom="1pt solid #000">
            <xsl:if test="preceding-sibling::*">  </xsl:if>
            <xsl:apply-templates/>
        </fo:inline>
    </xsl:template>
    <xsl:template match="*[@render = 'doublequote'] | *[@altrender = 'doublequote']"><xsl:if test="preceding-sibling::*">  </xsl:if>"<xsl:apply-templates/>" </xsl:template>
    <xsl:template match="*[@render = 'italic'] | *[@altrender = 'italic']">
        <fo:inline font-style="italic">
            <xsl:if test="preceding-sibling::*">  </xsl:if>
            <xsl:apply-templates/>
        </fo:inline>
    </xsl:template>
    <xsl:template match="*[@render = 'singlequote'] | *[@altrender = 'singlequote']"><xsl:if test="preceding-sibling::*">  </xsl:if>'<xsl:apply-templates/>' </xsl:template>
    <xsl:template match="*[@render = 'smcaps'] | *[@altrender = 'smcaps']">
        <fo:inline font-variant="small-caps">
            <xsl:if test="preceding-sibling::*">  </xsl:if>
            <xsl:apply-templates/>
        </fo:inline>
    </xsl:template>
    <xsl:template match="*[@render = 'sub'] | *[@altrender = 'sub']">
        <fo:inline baseline-shift="sub">
            <xsl:apply-templates/>
        </fo:inline>
    </xsl:template>
    <xsl:template match="*[@render = 'super'] | *[@altrender = 'super']">
        <fo:inline baseline-shift="super">
            <xsl:apply-templates/>
        </fo:inline>
    </xsl:template>
    <xsl:template match="*[@render = 'underline'] | *[@altrender = 'underline']">
        <fo:inline text-decoration="underline">
            <xsl:apply-templates/>
        </fo:inline>
    </xsl:template>
    <!-- Formatting elements -->
    <xsl:template match="ead:p">
        <xsl:choose>
            <xsl:when test="preceding-sibling::ead:p">
                <fo:block margin-top="4pt">
                    <xsl:apply-templates/>
                </fo:block>
            </xsl:when>
            <xsl:otherwise><xsl:apply-templates/></xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="ead:lb">
        <fo:block/>
    </xsl:template>
    <xsl:template match="ead:blockquote">
        <fo:block margin="4pt 18pt">
            <xsl:apply-templates/>
        </fo:block>
    </xsl:template>
    <xsl:template match="ead:emph[not(@render)]">
        <fo:inline font-style="italic">
            <xsl:apply-templates/>
        </fo:inline>
    </xsl:template>
    <xsl:template match="ead:index" mode="dsc">
        <xsl:apply-templates select="child::*[not(self::ead:indexentry)]"/>
        <fo:list-block xsl:use-attribute-sets="smpDsc">
            <xsl:apply-templates select="ead:indexentry"/>
        </fo:list-block>
    </xsl:template>
    <xsl:template match="ead:controlaccess" mode="dsc">
        <fo:block xsl:use-attribute-sets="smpDsc" text-decoration="underline"><xsl:value-of select="local:tagName(.)"/>:</fo:block>
        <fo:list-block xsl:use-attribute-sets="smpDsc">
            <xsl:apply-templates/>
        </fo:list-block>
    </xsl:template>
    <xsl:template match="ead:dao" mode="dsc">
        <xsl:variable name="title">
            <xsl:choose>
                <xsl:when test="child::*">
                    <xsl:apply-templates/>
                </xsl:when>
                <xsl:when test="@*:title">
                    <xsl:value-of select="@*:title"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="@*:href"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <fo:block xsl:use-attribute-sets="smpDsc">
            <fo:inline text-decoration="underline">
                <xsl:choose>
                    <!-- Test for label attribute used by origination element -->
                    <xsl:when test="@label">
                        <xsl:value-of select="local:ucfirst(@label)"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="local:tagName(.)"/>
                    </xsl:otherwise>
                </xsl:choose>
            </fo:inline>:
            <fo:basic-link external-destination="url('{@*:href}')" xsl:use-attribute-sets="ref">
                <xsl:value-of select="$title"/>
            </fo:basic-link>
        </fo:block>
    </xsl:template>
    <!-- Everything else in the dsc -->
    <xsl:template mode="dsc" match="*">
        <xsl:if test="child::*">
            <fo:block xsl:use-attribute-sets="smpDsc">
                <xsl:apply-templates/>
            </fo:block>
        </xsl:if>
    </xsl:template>
    <!-- Field label -->
    <xsl:template match="*" mode="fieldLabel">
        <xsl:choose>
            <!-- Don't use @label for ead:container-->
            <xsl:when test="self::ead:container">
                <xsl:value-of select="local:tagName(.)"/>
            </xsl:when>
            <xsl:when test="@label">
                <xsl:value-of select="local:ucfirst(@label)"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="local:tagName(.)"/>
            </xsl:otherwise>
        </xsl:choose>
        <xsl:if test="@type and not(self::ead:container)">
            [<xsl:value-of select="local:typeLabel(.)"/>]
        </xsl:if>
    </xsl:template>
    <!-- Field value -->
    <xsl:template match="ead:container" mode="fieldValue">
        <xsl:if test="key('physlocId', @parent)">
            <xsl:value-of select="key('physlocId', @parent)"/> &#8211;
        </xsl:if>
        <xsl:choose>
            <xsl:when test="@label">
                <xsl:value-of select="local:ucfirst(@label)"/>
                <xsl:value-of select="concat(' ', @type)"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="local:ucfirst(@type)"/>
            </xsl:otherwise>
        </xsl:choose>:
        <xsl:value-of select="."/>
    </xsl:template>
    <xsl:template match="*" mode="fieldValue">
        <xsl:apply-templates/>
        <xsl:if test="self::ead:unitdate">
            <xsl:choose>
                <xsl:when test="@datechar = 'accumulation'">
                    <xsl:text> </xsl:text>(<xsl:value-of select="@datechar"/>)
                </xsl:when>
                <xsl:otherwise>
                    <xsl:text> (creation)</xsl:text>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:if>
    </xsl:template>
</xsl:stylesheet>
