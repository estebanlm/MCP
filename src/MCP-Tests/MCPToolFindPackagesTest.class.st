Class {
	#name : 'MCPToolFindPackagesTest',
	#superclass : 'MCPTestCase',
	#category : 'MCP-Tests',
	#package : 'MCP-Tests'
}

{ #category : 'tests' }
MCPToolFindPackagesTest >> testFindPackagesByFilter [

	| tool request result |
	tool := MCPToolFindPackages new.
	request := tool requestFromToolCallArguments: { 'filter' -> 'MCP' } asDictionary.
	request validate.
	result := tool executeWithRequest: request.
	self assert: result notNil.
	self assert: (result isKindOf: MCPStructureCallToolResult)
]

{ #category : 'tests' }
MCPToolFindPackagesTest >> testRequestValidation [

	| tool request |
	tool := MCPToolFindPackages new.
	request := tool requestFromToolCallArguments: {  } asDictionary.
	self shouldnt: [ request validate ] raise: MCPInvalidToolInput.
	request := tool requestFromToolCallArguments: { 'filter' -> 'TestPattern' } asDictionary.
	self shouldnt: [ request validate ] raise: MCPInvalidToolInput
]

{ #category : 'tests' }
MCPToolFindPackagesTest >> testToolInstantiation [

	| tool |
	tool := MCPToolFindPackages new.
	self assert: tool defaultName equals: 'find-packages'
]
