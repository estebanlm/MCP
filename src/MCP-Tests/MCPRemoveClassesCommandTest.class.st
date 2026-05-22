Class {
	#name : 'MCPRemoveClassesCommandTest',
	#superclass : 'MCPTestCase',
	#category : 'MCP-Tests',
	#package : 'MCP-Tests'
}

{ #category : 'tests' }
MCPRemoveClassesCommandTest >> testRemoveSingleClass [
	| command createdClass |
	
	command := MCPCreateClassCommand
		        className: 'MCPTestToRemove2'
		        superclassName: 'Object'
		        packageName: 'MCP-Tests'
		        tag: nil
		        slots: #(  )
		        classSlots: #(  ).
	command execute.
	
	createdClass := Smalltalk globals at: #MCPTestToRemove2.
	[
		createdClass removeFromSystem.
		self deny: (Smalltalk globals includesKey: #MCPTestToRemove2) ] 
	ensure: [
		(Smalltalk globals includesKey: #MCPTestToRemove2) 
			ifTrue: [ createdClass removeFromSystem ] ]
]
