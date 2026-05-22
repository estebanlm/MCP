Class {
	#name : 'MCPTestCase',
	#superclass : 'TestCase',
	#category : 'MCP-Tests',
	#package : 'MCP-Tests'
}

{ #category : 'tests' }
MCPTestCase >> testOnePlusOne [

	self assert: 1 + 1 equals: 2
]
