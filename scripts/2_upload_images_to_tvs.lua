function JustNumbers( pvFileName )
         local lvStrLen = string.len( pvFileName );
         local i        = 0;
         local tStr     = "";
         for i = 1, lvStrLen do
             if string.find( "0123456789", string.sub( pvFileName, i, i ) ) ~= nil then
                if tStr .. string.sub( pvFileName, i, i ) ~= "." then
                   tStr     = tStr .. string.sub( pvFileName, i, i );
                end;
             end;
         end;
         tStr = string.sub(tStr,1,string.len(tStr)-1);
         return tStr;
end;

function UpdateClipFromPathSeparateKeyAndFill( pvPath )
         local lvFillPath           = pvPath .. "Fill\\";
         local lvKeyPath            = pvPath .. "Key\\";

         FSForceDirectories( lvFillPath );
         lvScanHandle                = FSScanPath( lvFillPath );
         for i = 1, FSScanResultGetCount( lvScanHandle ) do
             lvFileName             = FSScanResultGetEntryName( lvScanHandle, i );
             lvFileExtension        = FSExtractFileExtension( lvFileName );
             if string.upper( lvFileExtension ) == ".PNG" then
                lvFiles["COUNT"]                                 = lvFiles["COUNT"] + 1;
                lvFiles[lvFiles["COUNT"]]                        = {};
                lvFiles[lvFiles["COUNT"]]["FILL_NAME_WITH_PATH"] = lvFillPath .. lvFileName;
                lvFiles[lvFiles["COUNT"]]["NO"]                  = tonumber( JustNumbers( lvFileName ) );
             end;
         end;
         FSCloseScan( lvScanHandle );

         FSForceDirectories( lvKeyPath );
         lvScanHandle     = FSScanPath( lvKeyPath );
         for i = 1, FSScanResultGetCount( lvScanHandle ) do
             lvFileName         = FSScanResultGetEntryName( lvScanHandle, i );
             lvFileExtension    = FSExtractFileExtension( lvFileName );
             if string.upper( lvFileExtension ) == ".PNG" then
                lvFileNumber    = tonumber( JustNumbers( lvFileName ) );
                lvFiles["KEY_COUNT"] = lvFiles["KEY_COUNT"] + 1;
                for j = 1, lvFiles["COUNT"] do
                    if lvFiles[ j ]["NO"] == lvFileNumber then
                       lvFiles[ j ]["KEY_NAME_WITH_PATH"] = lvKeyPath .. lvFileName;
                       break;
                    end;
                end;
             end;
         end;
         FSCloseScan( lvScanHandle );


end;



function UploadImages()

    UpdateClipFromPath("E:\\InfoSlider\\InfoSlides\\");
end;



function UpdateClipFromPath( pvPath )

         local i                     = 0;
         local j                     = 0;
         local lvFiles               = {};
               lvFiles["COUNT"]      = 0;
               lvFiles["KEY_COUNT"]  = 0;
               lvFiles["FULL_COUNT"] = 0;
         local lvScanHandle          = "";
         local lvFileName            = "";
         local lvFileExtension       = "";
         local lvFileNumber          = 0;

         VSLog(pvPath);
         FSForceDirectories( pvPath );
         lvScanHandle     = FSScanPath( pvPath );
         VSLog("Images:" .. FSScanResultGetCount( lvScanHandle ));
         for i = 1, FSScanResultGetCount( lvScanHandle ) do
             lvFileName                                                 = FSScanResultGetEntryName( lvScanHandle, i );
             lvFileExtension                                            = FSExtractFileExtension( lvFileName );
             if string.upper( lvFileExtension )    == ".PNG" then
                lvFileNumber                                            = tonumber( JustNumbers( lvFileName ) );
                lvFiles["FULL_COUNT"]                                   = lvFiles["FULL_COUNT"] + 1;
                lvFiles[ lvFiles["FULL_COUNT"] ]                        = {};
                lvFiles[ lvFiles["FULL_COUNT"] ]["FULL_NAME_WITH_PATH"] = pvPath .. lvFileName;
                lvFiles[ lvFiles["FULL_COUNT"] ]["NO"]                  = lvFileNumber;
             end;
         end;
         FSCloseScan( lvScanHandle );
         pvClipNumber = 0;
         for i = 1, lvFiles["FULL_COUNT"] do
             VSLog(  "   " .. LPad( lvFiles[i]["NO"], 3 ) ..
                     "   " .. RPad( lvFiles[i]["FULL_NAME_WITH_PATH"], 110 ) ..
                     "   "  );
             ATEMMixerMediaStoreUploadStill(1,i, lvFiles[i]["FULL_NAME_WITH_PATH"], "FULL_OVERRIDE" )
             --ATEMMixerMediaStoreUploadClipFrame( 1, i, i, lvFiles[i]["FULL_NAME_WITH_PATH"], "FULL" );
         end;

         while ATEMMixerMediaStoreUploadQueueCount( 1 ) > 0 do
               VSLog("-------------- OUTSTANDING: " .. ATEMMixerMediaStoreUploadQueueCount( 1 ) );
               Sleep(5000);    
         end;
         --ATEMMixerMediaStoreValidateClip( 1, pvClipNumber, pvName, lvFiles["FULL_COUNT"] );
end;
                                        
CLS();
UploadImages()
