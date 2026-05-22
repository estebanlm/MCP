Class {
	#name : 'MCPToolRequestTest',
	#superclass : 'MCPTestCase',
	#category : 'MCP-Tests',
	#package : 'MCP-Tests'
}

{ #category : 'tests' }
MCPToolRequestTest >> testBasicRequest [

	| tool request |
	tool := MCPToolFindPackages new.
	request := MCPToolRequest tool: tool arguments: { 'filter' -> 'Test' } asDictionary.
	self assert: request tool equals: tool.
	self assert: (request stringArgumentNamed: 'filter') equals: 'Test'
]

{ #category : 'tests' }
MCPToolRequestTest >> testRequestValidationWithSchema [
	| tool request |
	
	tool := MCPToolFindPackages new.
	request := tool requestFromToolCallArguments: {  } asDictionary.
	self shouldnt: [ request validate ] raise: MCPInvalidToolInput
]
