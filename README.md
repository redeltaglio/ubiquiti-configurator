# Redama Ubigator
![Redama - la red que te ama](https://redama.es/Imagenes/internet_rural_ilimitado.webp)

Uno script en `bash` para configurar automáticamente antenas [Ubiquiti M](https://operator.ui.com/) para ser montadas en clientes y repetidores de un proveedor de servicios inalámbricos. 

- scapy CDP reconocer device
- ifconfig add alias ip
- ping test
- upload firmware

```shell
XW.v6.3.2-cs.33267.200715.1627# enable_ct 
Enable CT
Found  Active on[1] ...
Found Backup1 on[2] ...
Storing Active[2] ... [%100]
Active->Backup[1] ... [%100]
XW.v6.3.2-cs.33267.200715.1627#
```

- `F12` desde navegador y editar `input id="country" type="hidden"` y ponerlo en `511`
- Aplicar y salvar
- Advanced --> Installer EIRP control
- Wireless --> quitar Calculate EIRP Limit

![](https://redama.es/Imagenes/ubiquiti_compliance_test.png)

#### Wireshark HTTP primer arranque

``` html
GET / HTTP/1.1
Host: 192.168.1.20
User-Agent: Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:88.0) Gecko/20100101 Firefox/88.0
Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8
Accept-Language: en-US,en;q=0.5
Accept-Encoding: gzip, deflate
Connection: keep-alive
Cookie: ui_language=en_US; AIROS_002722489B9E=d12e91e0b2e42d5a953a0ad17e90a280; last_check=1622128085792; AIROS_44D9E76A5734=edf8b8375d67240818d630d559620125
Upgrade-Insecure-Requests: 1

HTTP/1.1 302 Found
Set-Cookie: AIROS_44D9E76A5734=cc87855257e74bd61a2367c196ea6169; Path=/; Version=1
Location: /cookiechecker?uri=/
Content-Length: 0
Date: Wed, 15 Jul 2020 16:28:29 GMT
Server: lighttpd/1.4.39

GET /cookiechecker?uri=/ HTTP/1.1
Host: 192.168.1.20
User-Agent: Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:88.0) Gecko/20100101 Firefox/88.0
Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8
Accept-Language: en-US,en;q=0.5
Accept-Encoding: gzip, deflate
Connection: keep-alive
Cookie: ui_language=en_US; AIROS_002722489B9E=d12e91e0b2e42d5a953a0ad17e90a280; last_check=1622128085792; AIROS_44D9E76A5734=cc87855257e74bd61a2367c196ea6169
Upgrade-Insecure-Requests: 1

HTTP/1.1 302 Found
Location: /
Content-Length: 0
Date: Wed, 15 Jul 2020 16:28:29 GMT
Server: lighttpd/1.4.39

GET / HTTP/1.1
Host: 192.168.1.20
User-Agent: Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:88.0) Gecko/20100101 Firefox/88.0
Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8
Accept-Language: en-US,en;q=0.5
Accept-Encoding: gzip, deflate
Connection: keep-alive
Cookie: ui_language=en_US; AIROS_002722489B9E=d12e91e0b2e42d5a953a0ad17e90a280; last_check=1622128085792; AIROS_44D9E76A5734=cc87855257e74bd61a2367c196ea6169
Upgrade-Insecure-Requests: 1

HTTP/1.1 302 Found
Location: /login.cgi?uri=/
Content-Length: 0
Date: Wed, 15 Jul 2020 16:28:29 GMT
Server: lighttpd/1.4.39

GET /login.cgi?uri=/ HTTP/1.1
Host: 192.168.1.20
User-Agent: Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:88.0) Gecko/20100101 Firefox/88.0
Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8
Accept-Language: en-US,en;q=0.5
Accept-Encoding: gzip, deflate
Connection: keep-alive
Cookie: ui_language=en_US; AIROS_002722489B9E=d12e91e0b2e42d5a953a0ad17e90a280; last_check=1622128085792; AIROS_44D9E76A5734=cc87855257e74bd61a2367c196ea6169
Upgrade-Insecure-Requests: 1

HTTP/1.1 200 OK
Set-Cookie: ui_language=en_US; Path=/; Expires=Tuesday, 1-Jan-38 00:00:00 GMT; HttpOnly
Content-Type: text/html
Transfer-Encoding: chunked
Date: Wed, 15 Jul 2020 16:28:29 GMT
Server: lighttpd/1.4.39

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/DTD/loose.dtd">
<html>
<head>
<title>Login</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="Expires" content="0">
<meta http-equiv="Cache-Control" content="no-cache">
<link rel="shortcut icon" href="/200715.1626/favicon.ico" >
<link href="/200715.1626/login.css" rel="stylesheet" type="text/css">
<link href="/200715.1626/style.css" rel="stylesheet" type="text/css">
<link href="/200715.1626/help.css" rel="stylesheet" type="text/css">
<script type="text/javascript" language="javascript" src="jsl10n.cgi?l=en_US&v=/200715.1626"></script>
<script type="text/javascript" src="/200715.1626/js/jquery.js"></script>
<script type="text/javascript" src="/200715.1626/util.js"></script>
<script type="text/javascript" src="/200715.1626/index.js"></script>
<script type="text/javascript" src="/200715.1626/js/jquery.ui.js"></script>
<script type="text/javascript" language="javascript">
//<!--
var globals = {
	first_login : true,
	postback : false,
	fixed : false,
	country : ""
};

function onLangChange() {
	$("#lang_changed").val("yes");
	$("#loginform").submit();
}

function validateForm() {
	if ($("#lang_changed").val() == "yes")
		return true;

	if ($("#country").val() == "0") {
		$("#errmsg").text("Please select your country.");
		return false;
	}

	if (!$("#agreed").is(":checked")) {
		$("#errmsg").html("To use this product, you must agree to<br>terms of use.");
		return false;
	}

	return true;
}

function isMobile() {
	return  navigator.userAgent.match(/Android/i) ||
			navigator.userAgent.match(/BlackBerry/i) ||
			navigator.userAgent.match(/iPhone|iPad|iPod/i) ||
			navigator.userAgent.match(/Opera Mini/i) ||
			navigator.userAgent.match(/IEMobile/i);
}

$(document).ready(function() {
	$("#username").focus();
	cache_images([
		'main_top.png', 'main.png', 'link.png',
		'net.png', '4dv.png', 'srv.png',
		'system.png', 'border.gif', 'spectr.gif']);

	if (globals.first_login) {
		$("#ui_language").change(onLangChange);
		$("#loginform").submit(validateForm);
		if (!globals.postback && !globals.fixed)
			$("#country").val(0);
		else
			$("#country").val(globals.country);
	}

	if (isMobile() || $('.first_login').length) {
		$('.desktopView').addClass("initial_hide");
		$('.mobileView').removeClass("initial_hide");
	} else {
		$('.mobileView').addClass("initial_hide");
		$('.desktopView').removeClass("initial_hide");
	}
});
//-->
</script>
</head>

<body class="first_login">
<table border="0" cellpadding="0" cellspacing="0" align="center" class="loginsubtable">
<form enctype="multipart/form-data" id="loginform" method="post" action="/login.cgi">
	<tr>
		<td valign="top"><img src="/200715.1626/images/airos_logo.png"></td>
		<td class="loginsep">
				<input type="hidden" name="uri" id="uri" value="/index.cgi" />
				<table border="0" cellpadding="0" cellspacing="0" class="logintable" align="center">
					<tr>
						<td colspan="2" align="center">
							<div id="errmsg" class="error">
								
							</div>
						</td>
					</tr>
					<tr>
						<td colspan="2">&nbsp;</td>
					</tr>
					<tr>
						<td><label for="username">User Name:</label></td>
						<td><input class="config" type="text" name="username" id="username"/></td>
					</tr>
					<tr>
						<td><label for="password">Password:</label></td>
						<td><input class="config" type="password" name="password" id="password"/></td>
					</tr>
					
					<tr >
						<td><label for="country">Country:</label></td>
						<td>
							
								<select name="country" id="country"/>
								<option value="0">Select Your Country</option>
									<option value="32" selected>Argentina</option>
	<option value="51">Armenia</option>
	<option value="533">Aruba</option>
	<option value="36">Australia</option>
	<option value="40">Austria</option>
	<option value="31">Azerbaijan</option>
	<option value="48">Bahrain</option>
	<option value="52">Barbados</option>
	<option value="112">Belarus</option>
	<option value="56">Belgium</option>
	<option value="84">Belize</option>
	<option value="68">Bolivia</option>
	<option value="70">Bosnia and Herzegovina</option>
	<option value="76">Brazil</option>
	<option value="96">Brunei Darussalam</option>
	<option value="100">Bulgaria</option>
	<option value="116">Cambodia</option>
	<option value="124">Canada</option>
	<option value="2124">Canada (Licensed)</option>
	<option value="152">Chile</option>
	<option value="156">China</option>
	<option value="170">Colombia</option>
	<option value="188">Costa Rica</option>
	<option value="191">Croatia</option>
	<option value="196">Cyprus</option>
	<option value="203">Czech Republic</option>
	<option value="208">Denmark</option>
	<option value="214">Dominican Republic</option>
	<option value="218">Ecuador</option>
	<option value="818">Egypt</option>
	<option value="222">El Salvador</option>
	<option value="233">Estonia</option>
	<option value="246">Finland</option>
	<option value="250">France</option>
	<option value="268">Georgia</option>
	<option value="276">Germany</option>
	<option value="300">Greece</option>
	<option value="304">Greenland</option>
	<option value="308">Grenada</option>
	<option value="316">Guam</option>
	<option value="320">Guatemala</option>
	<option value="332">Haiti</option>
	<option value="340">Honduras</option>
	<option value="344">Hong Kong</option>
	<option value="348">Hungary</option>
	<option value="352">Iceland</option>
	<option value="356">India</option>
	<option value="360">Indonesia</option>
	<option value="368">Iraq</option>
	<option value="372">Ireland</option>
	<option value="376">Israel</option>
	<option value="380">Italy</option>
	<option value="388">Jamaica</option>
	<option value="400">Jordan</option>
	<option value="398">Kazakhstan</option>
	<option value="404">Kenya</option>
	<option value="410">Korea Republic</option>
	<option value="414">Kuwait</option>
	<option value="428">Latvia</option>
	<option value="422">Lebanon</option>
	<option value="511">Licensed</option>
	<option value="438">Liechtenstein</option>
	<option value="440">Lithuania</option>
	<option value="442">Luxembourg</option>
	<option value="446">Macau</option>
	<option value="807">Macedonia</option>
	<option value="458">Malaysia</option>
	<option value="470">Malta</option>
	<option value="484">Mexico</option>
	<option value="492">Monaco</option>
	<option value="499">Montenegro</option>
	<option value="504">Morocco</option>
	<option value="524">Nepal</option>
	<option value="528">Netherlands</option>
	<option value="530">Netherlands Antilles</option>
	<option value="554">New Zealand</option>
	<option value="566">Nigeria</option>
	<option value="578">Norway</option>
	<option value="512">Oman</option>
	<option value="586">Pakistan</option>
	<option value="591">Panama</option>
	<option value="598">Papua New Guinea</option>
	<option value="600">Paraguay</option>
	<option value="604">Peru</option>
	<option value="608">Philippines</option>
	<option value="616">Poland</option>
	<option value="620">Portugal</option>
	<option value="630">Puerto Rico (U.S. territory)</option>
	<option value="634">Qatar</option>
	<option value="642">Romania</option>
	<option value="643">Russia</option>
	<option value="646">Rwanda</option>
	<option value="652">Saint Barthelemy</option>
	<option value="682">Saudi Arabia</option>
	<option value="688">Serbia</option>
	<option value="702">Singapore</option>
	<option value="703">Slovakia</option>
	<option value="705">Slovenia</option>
	<option value="710">South Africa</option>
	<option value="724">Spain</option>
	<option value="144">Sri Lanka</option>
	<option value="748">Swaziland</option>
	<option value="752">Sweden</option>
	<option value="756">Switzerland</option>
	<option value="158">Taiwan</option>
	<option value="764">Thailand</option>
	<option value="780">Trinidad and Tobago</option>
	<option value="788">Tunisia</option>
	<option value="792">Turkey</option>
	<option value="804">Ukraine</option>
	<option value="784">United Arab Emirates</option>
	<option value="826">United Kingdom</option>
	<option value="840">United States</option>
	<option value="858">Uruguay</option>
	<option value="860">Uzbekistan</option>
	<option value="862">Venezuela</option>
	<option value="704">Viet Nam</option>


								</select>
							
						</td>
					</tr>
					<tr>
						<td><label for="ui_language">Language:</label></td>
						<td>
							<select name="ui_language" id="ui_language">
								<option value="en_US" selected>English</option><option value="cz_CZ">..esky</option><option value="de_DE">Deutsch</option><option value="fr_FR">Fran..ais</option><option value="it_IT">Italiano</option><option value="lt_LT">Lietuvi..kai</option><option value="pl_PL">Polski</option><option value="pt_PT">Portugu..s</option><option value="sp_SP">Espa..ol</option><option value="tr_TR">T..rk</option><option value="zh_CN">..................</option>
							</select>
							<input type="hidden" id="lang_changed" name="lang_changed" value="no" />
						</td>
					</tr>
					
					<tr>
						<td colspan="2">&nbsp;</td>
					</tr>
				</table>
		</td>
	</tr>

	
	<tr>
		<td colspan="2" class="license">
			
<script type="text/javascript" language="javascript">
function handle_licensed(country)
{
	if (country == "511" || country == "2124")
	{
		$(".n_lfua").hide();
		$(".lfua").css("display", "inline");
	}
	else
	{
		$(".lfua").hide();
		$(".n_lfua").css("display", "inline");
	}

}

$(document).ready(
	function()
	{
		$("#country_select").change(function() { handle_licensed($(this).val()); } ).change();
		$("#country").change(function() { handle_licensed($(this).val()); } ).change();
	}
);

</script>
<div class='legal_container'><strong>TERMS OF USE</strong><p>This Ubiquiti Networks, Inc. radio device must be professionally installed. Properly installed shielded Ethernet cable and earth grounding must be used as conditions of product warranty. It is the installer's responsibility to follow local country regulations including operation within legal frequency channels, output power, and Dynamic Frequency Selection (DFS) requirements. You are responsible for keeping the unit working according to these rules.<br><span class='lfua' style='display: none'><br>You have selected a "licensed" country option in the airOS firmware. Please note that your use of the licensed firmware is subject to your compliance at all times with the terms and restrictions of <a href='/200715.1626/help/en_US/legal_licensed_firmware.html' onclick='return showLegalText("/200715.1626/help/en_US/legal_licensed_firmware.html", "Close")'>the Licensed Firmware User Agreement (LFUA)</a>, including having received valid authorization from applicable governmental authorities to configure and use Ubiquiti products beyond their standard radio frequency settings. Ubiquiti reserves the right to request such information and records as may be reasonably necessary to confirm your compliance with the LFUA.</span></p><input type='checkbox' id='agreed'></input><label for='agreed'><span class='n_lfua'>I have read and agree to the TERMS OF USE, <a href='/200715.1626/help/en_US/legal_eula.html' onclick='return showLegalText("/200715.1626/help/en_US/legal_eula.html", "Close")'>EULA</a> and <a href='/200715.1626/help/en_US/legal_privacy_policy.html' onclick='return showLegalText("/200715.1626/help/en_US/legal_privacy_policy.html", "Close")'>PRIVACY POLICY</a></span><span class='lfua' style='display: none'>I have read and agree to the TERMS OF USE, <a href='/200715.1626/help/en_US/legal_eula.html' onclick='return showLegalText("/200715.1626/help/en_US/legal_eula.html", "Close")'>EULA</a>, <a href='/200715.1626/help/en_US/legal_licensed_firmware.html' onclick='return showLegalText("/200715.1626/help/en_US/legal_licensed_firmware.html", "Close")'>LFUA</a> and <a href='/200715.1626/help/en_US/legal_privacy_policy.html' onclick='return showLegalText("/200715.1626/help/en_US/legal_privacy_policy.html", "Close")'>PRIVACY POLICY</a></span></label></div>
		</td>
	</tr>
	

        <tr>
		<td colspan="2" class="submit" align="right">
			<input type="submit" value="Login" />
		</td>
	</tr>
</form>
</table>
<footer class="footer">
	<div class="umobileSection">
		<div class="mobileView">
			<img class="umobile" src="/200715.1626/images/unms.svg">&nbsp;
			<div class="umobileApp">
				<div class="umobileAppText">Have a SmartPhone? Try our new UNMS to install this device</div>
			</div>
			<a href="https://play.google.com/store/apps/details?id=com.ubnt.umobile">
			<img class="badge gplay" src="/200715.1626/images/gplay.svg" alt="GooglePlay"></a>&nbsp;
			<a href="https://itunes.apple.com/us/app/umobile-ubnt/id1183022489?mt=8">
			<img class="badge" src="/200715.1626/images/astore.svg" alt="AppleStore"></a>
		</div>
		<div class="desktopView">
			<a target="_blank" href="https://www.ubnt.com/software/">
				<img class="logos" src="/images/login-logos.svg">
			</a>
		</div>
	</div>
</footer>
</body>
</html>
GET /200715.1626/images/gplay.svg HTTP/1.1
Host: 192.168.1.20
User-Agent: Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:88.0) Gecko/20100101 Firefox/88.0
Accept: image/webp,*/*
Accept-Language: en-US,en;q=0.5
Accept-Encoding: gzip, deflate
Connection: keep-alive
Referer: http://192.168.1.20/login.cgi?uri=/
Cookie: ui_language=en_US; AIROS_002722489B9E=d12e91e0b2e42d5a953a0ad17e90a280; last_check=1622128085792; AIROS_44D9E76A5734=cc87855257e74bd61a2367c196ea6169

HTTP/1.1 200 OK
Content-Type: image/svg+xml
Accept-Ranges: bytes
ETag: "640363473"
Last-Modified: Wed, 15 Jul 2020 13:28:21 GMT
Content-Length: 5395
Date: Wed, 15 Jul 2020 16:28:30 GMT
Server: lighttpd/1.4.39

<svg id="Layer_1" data-name="Layer 1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" viewBox="0 0 512 151.66"><defs><style>.cls-1,.cls-2{fill:#fff;}.cls-1,.cls-3,.cls-4,.cls-5,.cls-6{fill-rule:evenodd;}.cls-3{fill:url(#GradientFill_1);}.cls-4{fill:url(#GradientFill_2);}.cls-5{fill:url(#GradientFill_3);}.cls-6{fill:url(#GradientFill_4);}</style><linearGradient id="GradientFill_1" x1="105.28" y1="97.95" x2="92.53" y2="72.93" gradientUnits="userSpaceOnUse"><stop offset="0" stop-color="#facd8a"/><stop offset="1" stop-color="#f5906c"/></linearGradient><linearGradient id="GradientFill_2" x1="95.43" y1="85.64" x2="45.64" y2="137.2" gradientUnits="userSpaceOnUse"><stop offset="0" stop-color="#e62d38"/><stop offset="1" stop-color="#78459a"/></linearGradient><linearGradient id="GradientFill_3" x1="94.11" y1="86.49" x2="46.97" y2="35.94" gradientUnits="userSpaceOnUse"><stop offset="0" stop-color="#e5eba5"/><stop offset="1" stop-color="#38bbba"/></linearGradient><linearGradient id="GradientFill_4" x1="62.88" y1="157.94" x2="62.88" y2="14.84" gradientUnits="userSpaceOnUse"><stop offset="0" stop-color="#8dd1cd"/><stop offset="1" stop-color="#006f8c"/></linearGradient></defs><title>google_black</title><path d="M20.72,0H491.28A20.72,20.72,0,0,1,512,20.72V130.93a20.73,20.73,0,0,1-20.73,20.73H20.72A20.72,20.72,0,0,1,0,130.93V20.72A20.72,20.72,0,0,1,20.72,0Z"/><path class="cls-1" d="M184.95,83.14H161v7.11h17c-.84,10-9.14,14.23-17,14.23a19,19,0,0,1,0-38,18.45,18.45,0,0,1,12.82,5.14l5-5.16a25.32,25.32,0,0,0-18.05-7.12,26.13,26.13,0,1,0,.38,52.26c14,0,24.23-9.58,24.23-23.76a21.33,21.33,0,0,0-.43-4.72Z"/><path class="cls-1" d="M205.42,84.59c4.84,0,9.42,3.91,9.42,10.21S210.28,105,205.4,105c-5.36,0-9.59-4.29-9.59-10.24s4.18-10.16,9.61-10.16Zm-.1-6.6a16.8,16.8,0,1,0,16.85,16.85c0-11.12-8.77-16.85-16.85-16.85Z"/><path class="cls-1" d="M242.55,84.59c4.84,0,9.42,3.91,9.42,10.21S247.4,105,242.52,105c-5.36,0-9.59-4.29-9.59-10.24s4.18-10.16,9.61-10.16Zm-.1-6.6A16.8,16.8,0,1,0,259.3,94.84c0-11.12-8.77-16.85-16.85-16.85Z"/><path class="cls-1" d="M279.46,84.59c4.43,0,9,3.78,9,10.23S283.9,105,279.36,105c-4.81,0-9.29-3.91-9.29-10.11,0-6.45,4.65-10.3,9.39-10.3ZM278.81,78c-9,0-16.12,7.91-16.12,16.78,0,10.11,8.23,16.81,16,16.81a11.1,11.1,0,0,0,9.21-4.08v3.31c0,5.79-3.52,9.26-8.83,9.26a9.31,9.31,0,0,1-8.6-6l-6.46,2.7c2.29,4.84,6.9,9.89,15.11,9.89,9,0,15.82-5.65,15.82-17.51V79h-7v2.85A11.88,11.88,0,0,0,278.81,78Z"/><path class="cls-1" d="M328,84.43A6.7,6.7,0,0,1,334.21,88l-15,6.29c-.65-4.87,4-9.87,8.82-9.87ZM327.7,78C319.18,78,312,84.74,312,94.74c0,10.58,8,16.85,16.48,16.85a17,17,0,0,0,14.07-7.37l-5.81-3.86a9.4,9.4,0,0,1-8.23,4.62c-4.72,0-6.89-2.59-8.24-5.09l22.52-9.35-1.17-2.74a15.21,15.21,0,0,0-14-9.84Z"/><rect class="cls-2" x="300.55" y="61.09" width="7.4" height="49.51"/><path class="cls-3" d="M95.63,98.2,112.38,89c1.89-1,3.88-3.68,0-5.8L95.62,74.09l-12,12.09Z"/><path class="cls-4" d="M83.62,86.18,45.23,124.86a5.22,5.22,0,0,0,3.11-.78L95.63,98.2Z"/><path class="cls-5" d="M83.62,86.18l12-12.09L48.34,48.3A5,5,0,0,0,45,47.85Z"/><path class="cls-6" d="M83.62,86.18,45,47.85c-1.59.36-2.88,1.74-2.86,4.5,0,4.48.32,64.24.34,68,0,2.6,1,4.42,2.94,4.59Z"/><rect class="cls-2" x="399.74" y="61.09" width="7.4" height="49.51"/><rect class="cls-2" x="360.51" y="61.09" width="7.4" height="49.51"/><path class="cls-1" d="M360.51,61.09H378.4a15.82,15.82,0,0,1,15.77,15.77h0A15.82,15.82,0,0,1,378.4,92.63H360.51V61.09Zm7.4,7.4V85.24h10.5a8.37,8.37,0,1,0,0-16.75Z"/><polygon class="cls-1" points="461.75 126.71 483.17 77.97 475.09 77.97 453.67 126.71 461.75 126.71"/><polygon class="cls-1" points="464.14 115.56 447.63 77.97 455.71 77.97 467.1 103.89 464.14 103.89 464.14 115.56"/><path class="cls-1" d="M437.41,110.6h7.4V92.79c1.16-18.36-22.12-22.68-30.93-9.45l6,4c4.31-7.53,16.6-5.8,17.41,2.27A32.79,32.79,0,0,0,425.9,88.3c-5.69.58-10.56,4.19-11.34,10.11-.42,3.2.3,7.14,2.53,9.55,3.48,3.74,9.19,4.25,13.89,3a12.73,12.73,0,0,0,6.43-4.32v4Zm0-14.31a11.14,11.14,0,0,1-8.19,8.18c-8.55,2.33-10.68-11.57,2-9.66A31.73,31.73,0,0,1,437.41,96.29Z"/><path class="cls-1" d="M158.92,31H148v3.24h7.74c-.38,4.54-4.16,6.48-7.72,6.48a8.65,8.65,0,0,1,0-17.29,8.4,8.4,0,0,1,5.83,2.34l2.27-2.35a11.52,11.52,0,0,0-8.22-3.24,12.09,12.09,0,0,0-12,11.86,12,12,0,0,0,12.16,11.92c6.37,0,11-4.36,11-10.81a9.7,9.7,0,0,0-.2-2.15Z"/><rect class="cls-2" x="203.51" y="20.94" width="3.37" height="22.53"/><path class="cls-1" d="M184.66,43.47H188V24.3h5.53V20.94H179.13V24.3h5.53Z"/><path class="cls-1" d="M162.67,43.47h12.91V40.1H166V33.88h8.4V30.52H166V24.3h9.54V20.94H162.67Z"/><path class="cls-1" d="M215.14,43.47h3.37V24.3H224V20.94H209.62V24.3h5.53Z"/><path class="cls-1" d="M244.68,40.68a8.65,8.65,0,1,1,8.44-8.62,8.51,8.51,0,0,1-8.44,8.62Zm0-20.54A12.09,12.09,0,0,0,232.7,32a12,12,0,0,0,24,0A12.09,12.09,0,0,0,244.68,20.14Z"/><polygon class="cls-1" points="260.03 43.47 263.39 43.47 263.39 27.05 274.21 43.47 277.57 43.47 277.57 20.93 274.2 20.93 274.2 37.34 263.39 20.93 260.03 20.93 260.03 43.47"/><path class="cls-3" d="M95.63,98.2,112.38,89c1.89-1,3.88-3.68,0-5.8L95.62,74.09l-12,12.09Z"/><path class="cls-4" d="M83.62,86.18,45.23,124.86a5.22,5.22,0,0,0,3.11-.78L95.63,98.2Z"/><path class="cls-5" d="M83.62,86.18l12-12.09L48.34,48.3A5,5,0,0,0,45,47.85Z"/><path class="cls-6" d="M83.62,86.18,45,47.85c-1.59.36-2.88,1.74-2.86,4.5,0,4.48.32,64.24.34,68,0,2.6,1,4.42,2.94,4.59Z"/></svg>GET /200715.1626/images/srv.png HTTP/1.1
Host: 192.168.1.20
User-Agent: Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:88.0) Gecko/20100101 Firefox/88.0
Accept: image/webp,*/*
Accept-Language: en-US,en;q=0.5
Accept-Encoding: gzip, deflate
Connection: keep-alive
Referer: http://192.168.1.20/login.cgi?uri=/
Cookie: ui_language=en_US; AIROS_002722489B9E=d12e91e0b2e42d5a953a0ad17e90a280; last_check=1622128085792; AIROS_44D9E76A5734=cc87855257e74bd61a2367c196ea6169

HTTP/1.1 200 OK
Expires: Thu, 15 Jul 2021 16:28:30 GMT
Cache-Control: max-age=31536000
Content-Type: image/png
Accept-Ranges: bytes
ETag: "2160863965"
Last-Modified: Wed, 15 Jul 2020 13:28:21 GMT
Content-Length: 1533
Date: Wed, 15 Jul 2020 16:28:30 GMT
Server: lighttpd/1.4.39

.PNG
.
...
IHDR...M.........}.F.....tRNS.?.?.?...V....IDATx......0...7.."..!......{P.HDT.O.Ht".+...GEm..63?*j.......8..P..w(..*....,....s>22...|3?.|.j.?.".J....Tq...	.......:u.PW>'cI{<........U1kp7......}..........M).N.h*.*.`:..<........3cJ...	..|J...
.2I.......Y..l....|..&>...A...v]e.X..Fqu......s...\...%g.X...02./..dZ..19Z.....w.....A;......G...g\.*.........>..D.b\..J..L.+..Z.....[..^...y.4.KF......-[..[..dIgW...j..Q'..o.....d!\dS)...fH.........&BP'N.H9e....d.....>.L...f..%.......~.`.........?.........W.^.r{..reh.L..W..5#-..R.%p..J...g$Y.^7n..z....A....K%.:.z.M...T.f..g...2.>K/..F.=XY.....	e.v..w....Sv.....g..[......rv.g...c..l.@...|......z.......M....+...|A.m..(~...:.va.M.Zu[...|..7I+..3	-....V%.	-.a
4.vp.'&...<..H$....k7.2;WJ......{.w|.n..7x..U.....}..Q^...R_..............[....\.!.$... e.d............0.l.2.g$a	.q+.3#	S.pTe...;v.m.m..UZ...+...\...
...N....=-....g/.	....+W3............Y.I"BR.J..x2.(...pu..e(.w ...............O.oc...l..Ex..Ux[[..R{G......'}...O)./H%........Q)}2.~.&....z....k=|.....5..:I)P}.g+.P|"...G...Q..Q..!1..'/..
.	E.k..;x. ....K.6o).....jM.t.>...m..p.X..o.......+f'.q.rl2.n...d	{..{........l.....D..... ..,L.F'#...w,.#.
.M ...`..m...I>.Bq.)...+..8...m...R.nv......3..IN.....{..$x..M..|ca.7....<..^.......
N.:......./......=M.+../<.j.om......U..!....;.......{?ou .{....O?..Lj...J..L;6.T=|...S...fDG \.}..2....f..A..2..;.C.z...{...6o....nf....(k....%r...."B......r..-".g....hBo.....?..>...|..o.3.#..s....BH2....E..].,...P72N.X.!!"..$. .a.?.E........}.....s.......................;.......IEND.B`.
```

#### EdgeOS upgrade

En nuestra red tenemos cabeceras EdgeOS, el sistema operativo de Ubiquiti que deriva de VyOS.

De reciente ha salido una vulnerabilidad muy preocupante acerca de las actualizaciones de firmware de nuestro producto estrella. Se seguridad en fundamental para el correcto funcionamiento y la misma seguridad de nuestros usuarios. La vulnerabilidad toma la identificación [CVE-2021-22909](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-22909) y es detallada por el fabricante en un articulo de su foro:

- [Security Advisory Bulletin 018](https://community.ui.com/releases/Security-Advisory-Bulletin-018-018/cfa1566b-4bf8-427b-8cc7-8cffba3a93a4)

#### Red IPSec a través de FTTH

