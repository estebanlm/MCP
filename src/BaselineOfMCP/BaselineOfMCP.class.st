Class {
	#name : 'BaselineOfMCP',
	#superclass : 'BaselineOf',
	#category : 'BaselineOfMCP',
	#package : 'BaselineOfMCP'
}

{ #category : 'baselines' }
BaselineOfMCP >> baseline: spec [

	<baseline>
	self defineDependencies: spec.
	self definePackages: spec.
	self defineGroups: spec
]

{ #category : 'baselines' }
BaselineOfMCP >> defineDependencies: spec [

	spec
		baseline: 'JRPC' with: [
			spec
				repository: 'github://juliendelplanque/JRPC:v3.2.1/src';
				loads: #( 'Deployment' ) ].
]

{ #category : 'baselines' }
BaselineOfMCP >> defineGroups: spec [

	spec
		group: 'Server' with: #( 'MCP' );
		group: 'Core' with: #( 'Server' 'MCP-Spec' );
		group: 'Tests'
		with:
			#( 'MCP-Tests-Resources' 'MCP-Tests' 'MCP-Tests-Resources-Extensions'
			   'MCP-Spec-Tests' )
]

{ #category : 'baselines' }
BaselineOfMCP >> definePackages: spec [
	"common"

	spec
		package: 'MCP'
		with: [ spec requires: #( 'JRPC' ) ].
	spec package: 'MCP-Spec' with: [ spec requires: #( 'MCP' ) ].
	spec
		package: 'MCP-Tests-Resources'
		with: [ spec requires: #( 'MCP' ) ].
	spec
		package: 'MCP-Tests'
		with: [ spec requires: #( 'MCP' 'MCP-Tests-Resources' ) ].
	spec
		package: 'MCP-Tests-Resources-Extensions'
		with: [ spec requires: #( 'MCP-Tests-Resources' ) ].
	spec
		package: 'MCP-Spec-Tests'
		with: [ spec requires: #( 'MCP-Spec' 'MCP-Tests' ) ]
]
