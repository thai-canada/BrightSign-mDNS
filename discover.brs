Function discover_Initialize(msgPort As Object, userVariables As Object, bsp as Object)

	print "=== discover_itialize - entry"
	'dl = createobject("roSystemLog")
	
	
	h = {}
	h.version = "1.00.00"
	h.msgPort = msgPort
	h.userVariables = userVariables
	h.bsp = bsp
	h.ProcessEvent = discover_ProcessEvent
	h.objectName = "upload_object"

	nc = CreateObject("roNetworkConfiguration", 0)
	nc.SetHostName("brightsign-sfn-server")
	nc.Apply()




	nodePackage = createObject("roBrightPackage", bsp.assetPoolFiles.getPoolFilePath("discover.zip"))
	CreateDirectory("web_discover")
	nodePackage.Unpack("web_discover/")
	Deletefile("discover.zip")

	'filepath$ = GetPoolFilePath(bsp.assetPoolFiles, "users.htpasswd")
	'MoveFile(filepath$, "web_discover/users.htpasswd")


	'CreateDirectory("Auth")
	'myfile = bsp.assetPoolFiles.getPoolFilePath("auth.json")
	'MoveFile( myfile, "Auth")



	'dl.sendline("================= UNPACK ZIP FILE")
	'dl.sendline("================= DELETE ZIP FILE")
	
	url$ = "file:///sd:/web_discover/index.html"

	htmlRect = CreateObject("roRectangle", 0, 0, 1920, 1080)
	is = { port: 2999 }
	config = {
    	nodejs_enabled: true
    	inspector_server: is
		javascript_enabled: true
		security_params: {websecurity: false}
		storage_path: "SD:"
		storage_quota: 1073741824
    	brightsign_js_objects_enabled: true
		url: url$
	}
	h.htmlWidget = CreateObject("roHtmlWidget", htmlRect, config)
	h.htmlWidget.Hide()
	return h

End Function

Function discover_ProcessEvent(event As Object) as boolean
	return false
End Function

