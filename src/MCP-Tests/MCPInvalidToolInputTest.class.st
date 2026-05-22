Class {
	#name : 'MCPInvalidToolInputTest',
	#superclass : 'MCPTestCase',
	#category : 'MCP-Tests',
	#package : 'MCP-Tests'
}

{ #category : 'tests' }
MCPInvalidToolInputTest >> testSignalForToolViolations [

	| error schema |
	schema := {
		'type' -> 'object'.
		'properties' -> { 'name' -> { 'type' -> 'string' } asDictionary } asDictionary.
		'required' -> #('name')
	} asDictionary.
	[ 
		| request |
		request := (MCPToolFindPackages new) requestFromToolCallArguments: {  } asDictionary.
		" Simulate: the schema validator will add violations "
		" We directly test the error signal without actual validation "
		MCPInvalidToolInput signalForTool: (MCPToolFindPackages new)
			violations: (MCPJSONSchemaValidator violationsFor: {  } asDictionary schema: schema)
	] on: MCPInvalidToolInput do: [ :e | error := e ].
	self assert: error notNil.
	self assert: error toolName equals: 'find-packages'
]

{ #category : 'tests' }
MCPInvalidToolInputTest >> testSignalMissingRequired [

	| error |
	[ 
		MCPInvalidToolInput signalMissingRequiredArgumentNamed: 'filter'
			forTool: (MCPToolFindPackages new)
	] on: MCPInvalidToolInput do: [ :e | error := e ].
	self assert: error toolName equals: 'find-packages'
]
