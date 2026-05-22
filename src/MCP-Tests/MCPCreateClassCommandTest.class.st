Class {
	#name : 'MCPCreateClassCommandTest',
	#superclass : 'MCPTestCase',
	#category : 'MCP-Tests',
	#package : 'MCP-Tests'
}

{ #category : 'tests' }
MCPCreateClassCommandTest >> testCreateClassWithSlots [

	| cmd result cls |
	cmd := MCPCreateClassCommand
		className: 'MCPTestTempSlotted'
		superclassName: 'Object'
		packageName: 'MCP-Tests'
		tag: nil
		slots: #('x' 'y')
		classSlots: #('Count')
		.
	[ 
		result := cmd execute.
		cls := Smalltalk globals at: #MCPTestTempSlotted.
		self assert: cls notNil.
		self assert: (cls slotNames includes: #x).
		self assert: (cls slotNames includes: #y).
		self assert: (cls class slotNames includes: #Count).
	] ensure: [
		cls ifNotNil: [ cls removeFromSystem ] ]
]

{ #category : 'tests' }
MCPCreateClassCommandTest >> testCreateSimpleClass [

	| cmd result cls |
	cmd := MCPCreateClassCommand
		className: 'MCPTestTempClass'
		superclassName: 'Object'
		packageName: 'MCP-Tests'
		tag: nil
		slots: #()
		classSlots: #().
	[ 
		result := cmd execute.
		cls := Smalltalk globals at: #MCPTestTempClass.
		self assert: cls notNil.
		self assert: cls superclass equals: Object.
		self assert: result class equals: MCPCreateClassResult.
	] ensure: [
		cls ifNotNil: [ cls removeFromSystem ] ]
]

{ #category : 'tests' }
MCPCreateClassCommandTest >> testDuplicateClassFails [

	| cmd |
	cmd := MCPCreateClassCommand
		className: 'MCP'
		superclassName: 'Object'
		packageName: 'MCP-Tests'
		tag: nil
		slots: #()
		classSlots: #().
	self should: [ cmd execute ] raise: MCPCommandError
]
