Class {
	#name : 'MCPJSONSchemaValidatorTest',
	#superclass : 'MCPTestCase',
	#category : 'MCP-Tests',
	#package : 'MCP-Tests'
}

{ #category : 'tests' }
MCPJSONSchemaValidatorTest >> testArrayType [

	| schema violations |
	schema := { 'type' -> 'array'. 'items' -> { 'type' -> 'string' } asDictionary } asDictionary.
	violations := MCPJSONSchemaValidator violationsFor: #('a' 'b') schema: schema.
	self assert: violations isEmpty.
	violations := MCPJSONSchemaValidator violationsFor: #('a' 2) schema: schema.
	self assert: violations size equals: 1
]

{ #category : 'tests' }
MCPJSONSchemaValidatorTest >> testBooleanType [

	| schema violations |
	schema := { 'type' -> 'boolean' } asDictionary.
	violations := MCPJSONSchemaValidator violationsFor: true schema: schema.
	self assert: violations isEmpty.
	violations := MCPJSONSchemaValidator violationsFor: false schema: schema.
	self assert: violations isEmpty.
	violations := MCPJSONSchemaValidator violationsFor: 'yes' schema: schema.
	self assert: violations size equals: 1
]

{ #category : 'tests' }
MCPJSONSchemaValidatorTest >> testInvalidType [

	| schema data violations |
	schema := {
		'type' -> 'object'.
		'properties' -> {
			'count' -> { 'type' -> 'integer' } asDictionary
		} asDictionary
	} asDictionary.
	data := { 'count' -> 'not-a-number' } asDictionary.
	violations := MCPJSONSchemaValidator violationsFor: data schema: schema.
	self assert: violations size equals: 1.
	self assert: violations first keyword equals: 'type'
]

{ #category : 'tests' }
MCPJSONSchemaValidatorTest >> testIsValid [

	| schema |
	schema := {
		'type' -> 'string'.
		'enum' -> #('a' 'b' 'c')
	} asDictionary.
	self assert: (MCPJSONSchemaValidator isValid: 'a' against: schema).
	self deny: (MCPJSONSchemaValidator isValid: 'd' against: schema)
]

{ #category : 'tests' }
MCPJSONSchemaValidatorTest >> testMissingRequiredProperty [

	| schema data violations |
	schema := {
		'type' -> 'object'.
		'properties' -> {
			'name' -> { 'type' -> 'string' } asDictionary
		} asDictionary.
		'required' -> #('name')
	} asDictionary.
	data := {  } asDictionary.
	violations := MCPJSONSchemaValidator violationsFor: data schema: schema.
	self assert: violations size equals: 1.
	self assert: violations first keyword equals: 'required'
]

{ #category : 'tests' }
MCPJSONSchemaValidatorTest >> testValidStringProperty [

	| schema data violations |
	schema := { 
		'type' -> 'object'.
		'properties' -> {
			'name' -> { 'type' -> 'string' } asDictionary
		} asDictionary
	} asDictionary.
	data := { 'name' -> 'test' } asDictionary.
	violations := MCPJSONSchemaValidator violationsFor: data schema: schema.
	self assert: violations isEmpty
]
