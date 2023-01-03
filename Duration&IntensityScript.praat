Text writing preferences: "UTF-8"

@splitstring: selected$("Sound"), "_"
speakerID$ = splitstring.array$ [1]
filepath$ = "/Users/yurmak/Documents/Linguistics/Phonetics/final_aspiration/Data_csvs/I&D_'speakerID$'.csv"
writeFileLine: filepath$, "SpeakerID,TokenID,SegmentLabel,Start,End,TotalDuration,Intensity"

full_sounds# = selected# ("Sound")
for x from 1 to size (full_sounds#)
	selectObject: full_sounds# [x]
	textgridName$ = "TextGrid " + selected$ ("Sound")
	plusObject: textgridName$
	@splitstring: selected$("Sound"), "_"
	tokenID$ = splitstring.array$ [2]
	@listDurationAndIntensity
endfor
selectObject (full_sounds#)

procedure listDurationAndIntensity
    Extract non-empty intervals: 1, "yes"
	sounds# = selected# ("Sound")
	for i from 1 to size (sounds#)
		selectObject: selected ("Sound", -i)
		intensity = Get intensity (dB)
		start = Get start time
		end = Get end time
		total = Get total duration
		segmentLabel$ = selected$ ("Sound")
		segmentLabel$ = replace$ (segmentLabel$, "с", "c", 0)
		segmentLabel$ = replace$ (segmentLabel$, "к", "r", 0)
		segmentLabel$ = replace$ (segmentLabel$, "ф", "a", 0)
		segmentLabel$ = replace$ (segmentLabel$, "м", "v", 0)
		appendFileLine: filepath$, "'speakerID$','tokenID$','segmentLabel$','start','end','total','intensity'"
		selectObject (sounds#)
	endfor
	removeObject (sounds#)
endproc

## James Kirby <j.kirby@ed.ac.uk>
## 23 February 2017
## (adapted from a procedure by Paul Boersma)
## https://github.com/kirbyj/praatdet/blob/master/splitstring.praat

procedure splitstring: .string$, .sep$
    .strLen = 0
    repeat
        .sepIndex = index (.string$, .sep$)
        if .sepIndex <> 0
            .value$ = left$ (.string$, .sepIndex - 1)
            .string$ = mid$ (.string$, .sepIndex + 1, 10000)
        else
            .value$ = .string$
        endif
        .strLen = .strLen + 1
        .array$[.strLen] = .value$
    until .sepIndex = 0
endproc
 