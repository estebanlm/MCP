"
Executes a compile-check for validate-code, reporting syntax errors and selectors with no known implementors.
"
Class {
	#name : 'MCPValidateCodeCommand',
	#superclass : 'Object',
	#instVars : [
		'request',
		'tool'
	],
	#category : 'MCP-Commands',
	#package : 'MCP',
	#tag : 'Commands'
}

{ #category : 'instance creation' }
MCPValidateCodeCommand class >> tool: aTool request: aRequest [

	^ self new initializeTool: aTool request: aRequest
]

{ #category : 'private' }
MCPValidateCodeCommand >> checkUnknownSelectorsWithRuntimeError: runtimeErrorOrNil [

	| selectors unknown |
	selectors := (Smalltalk compiler parse: request code) sentMessages.
	unknown := selectors reject: [ :each | (SystemNavigation new allImplementorsOf: each) notEmpty ].
	unknown
		ifEmpty: [
				^ MCPValidateCodeResult okData: {
						  (#valid -> true).
						  (#unknownSelectors -> #(  )) } asDictionary ]
		ifNotEmpty: [
				^ MCPValidateCodeResult okData: {
						  (#valid -> false).
						  (#unknownSelectors -> unknown asArray) } asDictionary ]
]

{ #category : 'private' }
MCPValidateCodeCommand >> compileFailureFor: anError [

	^ MCPValidateCodeResult errorSummary: (tool validateFailureMessageFor: anError) details: (tool errorDetailsFor: anError)
]

{ #category : 'executing' }
MCPValidateCodeCommand >> execute [
	"Compile-check the code without executing it. Reports syntax errors and unknown selectors."

	| compiler notice runtimeError |
	compiler := Smalltalk compiler.
	compiler compilationContext isScripting: true.
	notice := nil.
	compiler failBlock: [ :aNotice |
			notice := aNotice.
			nil ].
	runtimeError := nil.
	[ compiler evaluate: request code ]
		on: Exception
		do: [ :e |
				(PharoCompatibility syntaxNoticeFromException: e) ifNotNil: [ :syntaxNotice | ^ self syntaxFailureFor: syntaxNotice ].
				runtimeError := e ].
	notice ifNotNil: [ ^ self syntaxFailureFor: notice ].
	^ self checkUnknownSelectorsWithRuntimeError: runtimeError
]

{ #category : 'initialization' }
MCPValidateCodeCommand >> initializeTool: aTool request: aRequest [

	tool := aTool.
	request := aRequest
]

{ #category : 'accessing' }
MCPValidateCodeCommand >> request [

	^ request
]

{ #category : 'private' }
MCPValidateCodeCommand >> runtimeFailureFor: anError [

	^ MCPValidateCodeResult errorSummary: (tool validateFailureMessageFor: anError) details: (tool errorDetailsFor: anError)
]

{ #category : 'private' }
MCPValidateCodeCommand >> syntaxFailureFor: aNotice [

	| details |
	details := tool errorDetailsFor: aNotice.
	details at: #description put: 'Compilation failed due to syntax error.'.
	details at: #position put: aNotice position.
	^ MCPValidateCodeResult errorSummary: (tool validateFailureMessageFor: aNotice) details: details
]

{ #category : 'accessing' }
MCPValidateCodeCommand >> tool [

	^ tool
]
