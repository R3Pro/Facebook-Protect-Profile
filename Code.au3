#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=privacy.ico
#AutoIt3Wrapper_Outfile=FPP By Rabi3.exe
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
; This Code By R3 Pro
#include "_httprequest.au3"
#include <string.au3>
#include <IE.au3>
#include <Array.au3>
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#Region ### START Koda GUI section ### Form=
$Form1 = GUICreate("Protect Profile By Rabi3 ;)", 766, 544)
Local $oIE = ObjCreate("Shell.Explorer.2")
GUICtrlCreateObj($oIE, 0, 0, 766, 544)
$oIE.navigate("https://www.facebook.com/login.php")
_IELoadWait($oIE)
GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###
Global $Login = True
While 1
	If $Login Then
	$sHTML = _IEDocReadHTML($oIE)
	If StringInStr($sHTML,'data-click="profile_icon"') Then
	MsgBox(0,"","Logged in successfully")

		$oIE.navigate("http://facebook.com/profile.php")
			_IELoadWait($oIE)
			$sHTML = _IEDocReadHTML($oIE)
			$zzi = StringSplit($sHTML,'access_token:"',1)

		If $zzi[0] > 1 Then
				If MsgBox(4,"","You are now in profile"&@CRLF&"Do you want to protect your profile?") = 6 Then
					$token = StringSplit($zzi[2],'"')[1]
					$code = _httprequest(2,'https://graph.facebook.com/me?access_token='&$token)
					$id = _StringBetween($code,'"id": "','"')[0]
					_httprequest(0,'https://graph.facebook.com/graphql','variables={"0":{"is_shielded":true,"session_id":"9b78191c-84fd-4ab6-b0aa-19b39f04a6bc","actor_id":"'&$id&'","client_mutation_id":"b0316dd6-3fd6-4beb-aed4-bb29c5dc64b0"}}&method=post&doc_id=1477043292367183&query_name=IsShieldedSetMutation&strip_defaults=true&strip_nulls=true&locale=en_US&client_country_code=US&fb_api_req_friendly_name=IsShieldedSetMutation&fb_api_caller_class=IsShieldedSetMutation','','','Authorization: OAuth '&$token)
					$oIE.navigate("http://facebook.com/profile.php")
					MsgBox(64,'Good','Profile now protected :)')
					$Login = False
				EndIf
		EndIf
	EndIf
	EndIf
	$nMsg = GUIGetMsg()
	Switch $nMsg
		Case $GUI_EVENT_CLOSE
			Exit

	EndSwitch
WEnd
