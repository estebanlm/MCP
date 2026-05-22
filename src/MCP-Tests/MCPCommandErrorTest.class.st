Class {
	#name : 'MCPCommandErrorTest',
	#superclass : 'MCPTestCase',
	#category : 'MCP-Tests',
	#package : 'MCP-Tests'
}

{ #category : 'tests' }
MCPCommandErrorTest >> testBasicAccessors [

	| error |
	[ 
		MCPCommandError signalErrorCode: #TestCode message: 'test message' details: { #key -> 'value' } asDictionary
	] on: MCPCommandError do: [ :e | error := e ].
	self assert: error errorCode equals: #TestCode.
	self assert: error messageText equals: 'test message'.
	self assert: (error details at: #key) equals: 'value'
]

{ #category : 'tests' }
MCPCommandErrorTest >> testSignalClassAlreadyExists [

	| error |
	[ 
		MCPCommandError signalClassAlreadyExistsNamed: 'TestClass'
	] on: MCPCommandError do: [ :e | error := e ].
	self assert: error errorCode equals: #ClassAlreadyExists.
	self assert: (error details at: #className) equals: 'TestClass'
]

{ #category : 'tests' }
MCPCommandErrorTest >> testSignalMissingClassNamed [

	| error |
	[ 
		MCPCommandError signalMissingClassNamed: 'NonExistentClass'
	] on: MCPCommandError do: [ :e | error := e ].
	self assert: error errorCode equals: #ClassNotFound.
	self assert: (error details at: #className) equals: 'NonExistentClass'
]
