"
MCP tool that compile-checks Smalltalk code without executing it. Reports syntax errors and unknown selectors.
"
Class {
	#name : 'MCPToolValidateCode',
	#superclass : 'MCPTool',
	#category : 'MCP-Tools',
	#package : 'MCP',
	#tag : 'Tools'
}

{ #category : 'scripts' }
MCPToolValidateCode class >> toolGroup [

	^ #Scripting
]

{ #category : 'private - execution' }
MCPToolValidateCode >> commandForRequest: aRequest [

	^ MCPValidateCodeCommand tool: self request: aRequest
]

{ #category : 'defaults' }
MCPToolValidateCode >> defaultDescription [

	^ 'Compile-check Smalltalk code without executing it. Reports syntax errors and selectors with no known implementors.'
]

{ #category : 'defaults' }
MCPToolValidateCode >> defaultInputSchema [

	^ MCPStructureInputSchema new
		  type: 'object';
		  properties: { (MCPStructureProperties new
				   name: 'code';
				   type: 'string';
				   description: 'The Smalltalk code to compile-check.';
				   yourself) };
		  required: #( 'code' );
		  yourself
]

{ #category : 'defaults' }
MCPToolValidateCode >> defaultName [

	^ 'validate-code'
]

{ #category : 'defaults' }
MCPToolValidateCode >> defaultOutputSchema [

	^ self
		  standardOutputSchemaForDataProperties: {
				  (self booleanSchemaPropertyNamed: 'valid' description: 'Whether the code compiled without issues.').
				  (self
					   stringArraySchemaNamed: 'unknownSelectors'
					   description: 'Selectors sent in the code that have no implementors in the image.'
					   itemDescription: 'A selector without known implementors.') }
		  required: #( 'valid' 'unknownSelectors' )
]

{ #category : 'defaults' }
MCPToolValidateCode >> defaultTitle [

	^ 'Validate Smalltalk Code'
]

{ #category : 'executing' }
MCPToolValidateCode >> executeWithRequest: toolRequest [

	^ self
		  executeParsedRequestFrom: toolRequest
		  do: [ :validateRequest |
				  | commandResult |
				  commandResult := (self commandForRequest: validateRequest) execute.
				  commandResult isError
					  ifTrue: [ self errorResultText: commandResult summary details: commandResult errorDetails ]
					  ifFalse: [ self successResultText: 'Code validated.' data: commandResult data ] ]
		  onError: [ :e :ignored |
			  self
				  errorResultText: (e messageText ifNil: [ e asString ] ifNotNil: [ :text | text asString ])
				  details: (self errorDetailsFor: e) ]
]

{ #category : 'private - results' }
MCPToolValidateCode >> formattedDataContentBlocks: dataDictionary [

	| valid unknown blocks |
	valid := dataDictionary at: #valid.
	unknown := dataDictionary at: #unknownSelectors.
	blocks := OrderedCollection new.
	valid
		ifTrue: [ blocks add: (self textContent: 'Code is valid. All selectors have known implementors.') ]
		ifFalse: [ blocks add: (self textContent: 'Code compiles but sends unknown selectors: ' , (unknown sorted joinUsing: ', ')) ].
	^ blocks
]

{ #category : 'private - request' }
MCPToolValidateCode >> parsedRequestFromToolRequest: aRequest [

	^ MCPValidateCodeRequest fromRequest: aRequest tool: self
]

{ #category : 'testing' }
MCPToolValidateCode >> shouldSaveImageAfterSuccessfulExecution [

	^ false
]

{ #category : 'private' }
MCPToolValidateCode >> validateFailureMessageFor: anError [

	^ String streamContents: [ :stream |
			  stream nextPutAll: 'Validation failed ('.
			  (anError respondsTo: #position)
				  ifTrue: [
						  stream
							  nextPutAll: anError class name;
							  nextPutAll: '): ';
							  nextPutAll: anError messageText;
							  nextPutAll: ' Position: ';
							  print: anError position ]
				  ifFalse: [
						  stream
							  nextPutAll: anError class name;
							  nextPutAll: '): ';
							  nextPutAll: (anError messageText ifNil: [ anError asString ] ifNotNil: [ :text | text asString ]) ] ]
]
