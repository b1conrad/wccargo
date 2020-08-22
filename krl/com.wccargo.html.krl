ruleset com.wccargo.html {
  meta {
    provides header, footer
    shares __testing
  }
  global {
    __testing = { "queries":
      [ { "name": "__testing" }
      //, { "name": "entry", "args": [ "key" ] }
      ] , "events":
      [ //{ "domain": "d1", "type": "t1" }
      //, { "domain": "d2", "type": "t2", "attrs": [ "a1", "a2" ] }
      ]
    }
    header = function(title,scripts) {
      <<<!DOCTYPE HTML>
<html>
  <head>
    <title>#{title}</title>
    <meta charset="UTF-8">
<style type="text/css">

<!--

body,td,th {

	font-family: Trebuchet MS, Arial, Helvetica, sans-serif;

	font-size: 12px;

	color: #000;

}

body {
	background-color: #FFF;
	background-repeat: repeat-x;
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
}

-->

</style>
    <link href="http://wccargo.com/styles.css" rel="stylesheet" type="text/css" />
#{scripts.defaultsTo("")}
<style type="text/css">

<!--

a:link {
	color: #F00;
}

a:visited {
	color: #900;
}

a:hover {
	color: #F00;
}

a:active {

	color: #B25253;

}

h1 {
	font-size: 24px;
	color: #F00;
	border-bottom:#000 solid 1px;
}

h2 {

	font-size: 18px;

	color: #333;

	border-bottom:#000 solid 1px;

}

h3 {

	font-size: 18px;

	color: #900;

	border-bottom:#000 solid 1px;

}

h4 {

	font-size: 16px;

	color: #333;

	border-bottom:#000 solid 1px;

}

-->

</style>
  </head>
  <body>
<table width="822" border="1" align="center" cellpadding="0" cellspacing="0">

  <tr>

    <td><a href="http://wccargo.com/index.html"><div class="logo"></div></a></div><!-- #BeginLibraryItem "/Library/topmenu.lbi" -->    
<link href="http://wccargo.com/styles.css" rel="stylesheet" type="text/css">

<div class="top_menu_back">

      <div class="buttonmenu"><a href="http://wccargo.com/company.html" >Company</a> <a href="http://wccargo.com/services.html">Services</a> <a href="http://wccargo.com/projects.html" >Expo Logistics</a> <a href="http://wccargo.com/contact.html" >Contact Us</a></div>

    </div><!-- #EndLibraryItem --><table width="822" border="0" align="left" cellpadding="0" cellspacing="0">

      <tr>

    <td width="2"></td>

    <td width="822"><div class="content">

      <table width="822" border="0" align="left" cellpadding="5" cellspacing="0">

        <tr>
          
          <td width="165" valign="top" bgcolor="#E2E2E2"><div class="left_menu_back">
            
            <div class="blueblock"><ul>
                           
               <li><a href="http://wccargo.com/contact.html">Contact</a></li>
              
              <li><a href="http://wccargo.com/alliances.html">Licenses and Authorizations</a></li>
              
              
              </ul></div>
            
            </div></td>
          <td width="657" valign="top">
>>
    }
    footer = function() {
      <<   </td></tr></table><!-- #BeginLibraryItem "/Library/foot.lbi" -->
<link href="http://wccargo.com/styles.css" rel="stylesheet" type="text/css">
<tr>

          <td height="20" colspan="2" valign="top" bgcolor="#FFFFFF"><div class="footer"><p>
<hr align="center" size="1" noshade>

            &copy; 2009 - 2020 World Connections. All Rights Reserved.</p>

  <!--keep the link please --> </div></td>

</tr><!-- #EndLibraryItem --><table width="822" border="0" align="left" cellpadding="5" cellspacing="0">
      </table>

      </div></td>

  </tr>

</table>

    </td>

  </tr>

</table>
  </body>
</html>
>>
    }
  }
}
