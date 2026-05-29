"
A parsed MCP validate-code request wrapping the Smalltalk source code to check.
"
Class {
	#name : 'MCPValidateCodeRequest',
	#superclass : 'Object',
	#instVars : [
		'code'
	],
	#category : 'MCP-Requests',
	#package : 'MCP',
	#tag : 'Requests'
}

{ #category : 'instance creation' }
MCPValidateCodeRequest class >> fromRequest: aRequest tool: aTool [

	^ self new initializeCode: (aRequest stringArgumentNamed: 'code')
]

{ #category : 'accessing' }
MCPValidateCodeRequest >> code [

	^ code
]

{ #category : 'initialization' }
MCPValidateCodeRequest >> initializeCode: aString [

	code := aString
]
