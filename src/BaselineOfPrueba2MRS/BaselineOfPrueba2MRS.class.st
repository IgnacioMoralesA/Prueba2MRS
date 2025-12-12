Class {
	#name : 'BaselineOfPrueba2MRS',
	#superclass : 'BaselineOf',
	#category : 'BaselineOfPrueba2MRS',
	#package : 'BaselineOfPrueba2MRS'
}

{ #category : 'loading' }
BaselineOfPrueba2MRS class >> loadLepiter [
	IceRepository registry  
		detect: [ :aRepository |
			aRepository name = 'Prueba2MRS' ]
		ifFound: [ :aRepository | 
			| defaultDatabase currentProperties |
			defaultDatabase := LeDatabasesRegistry defaultLogicalDatabase.
			currentProperties := defaultDatabase properties.
			currentProperties addRegisteredDirectory: aRepository repositoryDirectory / 'lepiter'.
			defaultDatabase reload ]
		ifNone: [
			self inform: 'Repository not found.' ]
]

{ #category : 'baseline' }
BaselineOfPrueba2MRS >> baseline: spec [
	<baseline>
		^ spec for: #common do: [
			spec package: 'Prueba2MRS'
		]
]
