function Initialize()
    Parse()
end

function Update()
    return
end

function Parse()
    local measure = SKIN:GetMeasure('MeasureStatsJSON')
    if not measure then
        SKIN:Bang('!SetVariable', 'EloValue', 'NO_MEASURE')
        SKIN:Bang('!UpdateMeter', '*')
        SKIN:Bang('!Redraw')
        return
    end

    local json = measure:GetStringValue()
    if not json or json == '' then
        SKIN:Bang('!SetVariable', 'EloValue', 'NO_JSON')
        SKIN:Bang('!UpdateMeter', '*')
        SKIN:Bang('!Redraw')
        return
    end

    local rating = json:match('"chess_rapid"%s*:%s*{.-"last"%s*:%s*{.-"rating"%s*:%s*(%d+)')
    local win    = json:match('"chess_rapid"%s*:%s*{.-"record"%s*:%s*{.-"win"%s*:%s*(%d+)')
    local loss   = json:match('"chess_rapid"%s*:%s*{.-"record"%s*:%s*{.-"loss"%s*:%s*(%d+)')
    local draw   = json:match('"chess_rapid"%s*:%s*{.-"record"%s*:%s*{.-"draw"%s*:%s*(%d+)')

    SKIN:Bang('!SetVariable', 'EloValue', rating or 'NO_MATCH')
    SKIN:Bang('!SetVariable', 'Wins', win or 0)
    SKIN:Bang('!SetVariable', 'Losses', loss or 0)
    SKIN:Bang('!SetVariable', 'Draws', draw or 0)
    SKIN:Bang('!SetVariable', 'LastUpdate', os.date('%H:%M'))

    SKIN:Bang('!UpdateMeter', '*')
    SKIN:Bang('!Redraw')
end
