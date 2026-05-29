"
The result of an MCP validate-code execution, holding status, data, summary, and error details.
"
Class {
	#name : 'MCPValidateCodeResult',
	#superclass : 'Object',
	#instVars : [
		'status',
		'data',
		'summary',
		'errorDetails'
	],
	#category : 'MCP-Results',
	#package : 'MCP',
	#tag : 'Results'
}

{ #category : 'instance creation' }
MCPValidateCodeResult class >> errorSummary: aString details: aDictionary [

	^ self new
		  initializeStatus: #error
		  data: nil
		  summary: aString
		  errorDetails: aDictionary
]

{ #category : 'instance creation' }
MCPValidateCodeResult class >> okData: aDictionary [

	^ self new
		  initializeStatus: #ok
		  data: aDictionary
		  summary: nil
		  errorDetails: nil
]

{ #category : 'accessing' }
MCPValidateCodeResult >> data [

	^ data
]

{ #category : 'accessing' }
MCPValidateCodeResult >> errorDetails [

	^ errorDetails
]

{ #category : 'initialization' }
MCPValidateCodeResult >> initializeStatus: aSymbol data: aDictionary summary: aString errorDetails: anObject [

	status := aSymbol.
	data := aDictionary.
	summary := aString.
	errorDetails := anObject
]

{ #category : 'testing' }
MCPValidateCodeResult >> isError [

	^ status = #error
]

{ #category : 'accessing' }
MCPValidateCodeResult >> status [

	^ status
]

{ #category : 'accessing' }
MCPValidateCodeResult >> summary [

	^ summary
]
