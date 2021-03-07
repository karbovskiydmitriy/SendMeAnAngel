format PE GUI
entry main

	include 	"win32a.inc"
	include 	"MIDI_instruments.inc"

	Octave		=	12
	C		=	0
	C_sharp 	=	1
	D		=	2
	D_sharp 	=	3
	E		=	4
	F		=	5
	F_sharp 	=	6
	G		=	7
	G_sharp 	=	8
	A		=	9
	B		=	10
	H		=	11
	Transpose	=	-1
	Drop		=	0
	Guitar_1	=	Octave * 5 + E + Transpose
	Guitar_2	=	Octave * 4 + H + Transpose
	Guitar_3	=	Octave * 4 + G + Transpose
	Guitar_4	=	Octave * 4 + D + Transpose
	Guitar_5	=	Octave * 3 + A + Transpose
	Guitar_6	=	Octave * 3 + E + Transpose - Drop

	NOTE_ON 	=	0x007F0090
	PROGRAM_CHANGE	=	0x000000C0

	Instruent	=	MIDI_Acoustic_Guitar_steel

			;	Guitar_0 + 0, Guitar_0 + 0, Guitar_0 + 0, Guitar_0 + 0

	Verse_1 	equ	Guitar_4 + 2, Guitar_1 + 0, Guitar_2 + 0, Guitar_3 + 0,\
				Guitar_5 + 3, Guitar_1 + 0, Guitar_2 + 0, Guitar_3 + 0,\
				Guitar_5 + 5, Guitar_2 + 3, Guitar_3 + 2, Guitar_4 + 4,\
				Guitar_5 + 2, Guitar_2 + 3, Guitar_3 + 2, Guitar_4 + 4,\
				Guitar_4 + 2, Guitar_1 + 0, Guitar_2 + 0, Guitar_3 + 0,\
				Guitar_5 + 3, Guitar_1 + 0, Guitar_2 + 0, Guitar_3 + 0,\
				Guitar_5 + 5, Guitar_4 + 4, Guitar_3 + 2, Guitar_4 + 4,\
				Guitar_2 + 3, Guitar_4 + 4, Guitar_3 + 2, Guitar_4 + 4

	Chorus_1	equ	Guitar_4 + 4, Guitar_3 + 2, Guitar_2 + 2, Guitar_3 + 2,\
				Guitar_1 + 2, Guitar_3 + 2, Guitar_2 + 2, Guitar_3 + 2,\
				Guitar_4 + 2, Guitar_3 + 1, Guitar_2 + 0, Guitar_3 + 1,\
				Guitar_1 + 0, Guitar_3 + 1, Guitar_2 + 0, Guitar_3 + 1,\
				Guitar_5 + 4, Guitar_4 + 2, Guitar_3 + 1, Guitar_4 + 2,\
				Guitar_2 + 0, Guitar_4 + 2, Guitar_3 + 1, Guitar_4 + 2,\
				Guitar_5 + 5, Guitar_4 + 4, Guitar_3 + 2, Guitar_4 + 4,\
				Guitar_5 + 7, Guitar_4 + 6, Guitar_3 + 4, Guitar_4 + 6

	Verse_2 	equ	Guitar_4 + 4, Guitar_1 + 2, Guitar_2 + 2, Guitar_3 + 2,\
				Guitar_5 + 5, Guitar_1 + 2, Guitar_2 + 2, Guitar_3 + 2,\
				Guitar_5 + 7, Guitar_2 + 5, Guitar_3 + 4, Guitar_4 + 6,\
				Guitar_5 + 4, Guitar_2 + 5, Guitar_3 + 4, Guitar_4 + 6,\
				Guitar_4 + 4, Guitar_1 + 2, Guitar_2 + 2, Guitar_3 + 2,\
				Guitar_5 + 5, Guitar_1 + 2, Guitar_2 + 2, Guitar_3 + 2,\
				Guitar_5 + 7, Guitar_4 + 6, Guitar_3 + 4, Guitar_4 + 6,\
				Guitar_2 + 5, Guitar_4 + 6, Guitar_3 + 4, Guitar_4 + 6

	Chorus_2	equ	Guitar_4 + 6, Guitar_3 + 4, Guitar_2 + 4, Guitar_3 + 4,\
				Guitar_1 + 4, Guitar_3 + 4, Guitar_2 + 4, Guitar_3 + 4,\
				Guitar_4 + 4, Guitar_3 + 3, Guitar_2 + 2, Guitar_3 + 3,\
				Guitar_1 + 2, Guitar_3 + 3, Guitar_2 + 2, Guitar_3 + 3,\
				Guitar_5 + 6, Guitar_4 + 4, Guitar_3 + 3, Guitar_4 + 4,\
				Guitar_3 + 6, Guitar_4 + 4, Guitar_3 + 3, Guitar_4 + 4,\
				Guitar_5 + 7, Guitar_4 + 6, Guitar_3 + 4, Guitar_4 + 6,\
				Guitar_5 + 9, Guitar_4 + 8, Guitar_3 + 6, Guitar_4 + 8

	Verse_3 	equ	Guitar_4 + 2, Guitar_1 + 0, Guitar_2 + 0, Guitar_3 + 0,\
				Guitar_5 + 3, Guitar_1 + 0, Guitar_2 + 0, Guitar_3 + 0,\
				Guitar_5 + 2, Guitar_1 + 0, Guitar_2 + 0, Guitar_3 + 0,\
				Guitar_6 + 3, Guitar_1 + 0, Guitar_2 + 0, Guitar_3 + 0,\
				Guitar_4 + 2, Guitar_1 + 0, Guitar_2 + 0, Guitar_3 + 0,\
				Guitar_5 + 3, Guitar_1 + 0, Guitar_2 + 0, Guitar_3 + 0,\
				Guitar_5 + 5, Guitar_4 + 4, Guitar_3 + 2, Guitar_4 + 4,\
				Guitar_2 + 3, Guitar_4 + 4, Guitar_3 + 2, Guitar_4 + 4

	hMidiOut	dd	?
	BMP		equ	52
	TACT		equ	4
	interval	dd	(60 * 1000) / BMP / TACT; 321
	count		dd	COUNT

	notes:		db	Verse_1, Verse_1, Verse_1, Verse_1, Verse_1, Verse_1,\
				Chorus_1, Chorus_1,\
				Verse_2, Verse_2, Verse_2, Verse_2, Verse_2, Verse_2,\
				Chorus_2, Chorus_2,\
				Verse_1, Verse_1,\
				Verse_3, Verse_3, Verse_3, Verse_3

	COUNT		=	($ - notes)

proc main
	xor	ebx, ebx
	invoke	midiOutOpen, hMidiOut, -1, ebx, ebx, ebx
	invoke	midiOutShortMsg, [hMidiOut], PROGRAM_CHANGE or (Instruent shl 8)

	mov	ecx, [count]
	lea	esi, [notes]
.PlayLoop:
	push	ecx

	movzx	eax, byte[esi]
	inc	esi
	stdcall PlayNote, eax
	invoke	Sleep, [interval]

	pop	ecx
	loop	.PlayLoop

	invoke	Sleep, 5000

	invoke	midiOutClose, [hMidiOut]

	ret
endp

proc PlayNote,\
     note

	mov	eax, [note]
	shl	eax, 8
	or	eax, NOTE_ON
	invoke	midiOutShortMsg, [hMidiOut], eax

	ret
endp

data import

	library kernel32,	"KERNEL32.DLL",\
		user32, 	"USER32.DLL",\
		winmm,		"WINMM.DLL"

	include "api\kernel32.inc"
	include "api\user32.inc"

	import	winmm,\
		midiOutOpen, "midiOutOpen",\
		midiOutShortMsg, "midiOutShortMsg",\
		midiOutClose, "midiOutClose"

end data

; The wise man said just walk this way
; To the dawn of the light
; The wind will blow into your face
; As the years pass you by
;
; Hear this voice from deep inside
; It's the call of your heart
; Close your eyes and you will find
; The passage out of the dark
;
; Here I am
; Will you send me an angel?
; Here I am
; In the land of the morning star
;
; The wise man said just find your place
; In the eye of the storm
; Seek the roses along the way
; Just beware of the thorns
;
; Here I am
; Will you send me an angel?
; Here I am
; In the land of the morning star
;
; The wise man said just raise your hand
; And reach out for the spell
; Find the door to the promised land
; Just believe in yourself
;
; Hear this voice from deep inside
; It's the call of your heart
; Close your eyes and you will find
; The way out of the dark
;
; [4x]
; Here I am
; Will you send me an angel?
; Here I am
; In the land of the morning star

; tabs from	https://www.songsterr.com/a/wsa/scorpions-send-me-an-angel-tab-s27749t0
; larycs from	https://www.azlyrics.com/lyrics/scorpions/sendmeanangel.html