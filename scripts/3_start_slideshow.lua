function InfoGraphic()
    local media_player = 1;
    while(true) do
    for i = 1, ATEMMixerMediaPoolStillsCount(1) do
        if media_player == 1 then
            media_player = 2;
        else
            media_player = 1;
        end;
        ATEMMixerMPSetMediaIndex( 1,media_player,i);
        if media_player == 1 then
            ATEMMixerMESetPreviewInput(  1, 1, 11);
        else
            ATEMMixerMESetPreviewInput(  1, 1, 13);
        end;
        ATEMMixerMEAutoTransition(1,1);
        VSLog("MediaPlayer: " .. media_player);
        Sleep(10000);
    end;
    end;

end;

InfoGraphic()    
