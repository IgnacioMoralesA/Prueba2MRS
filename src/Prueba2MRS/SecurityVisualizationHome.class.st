Class {
	#name : 'SecurityVisualizationHome',
	#superclass : 'Object',
	#category : 'Prueba2MRS',
	#package : 'Prueba2MRS'
}

{ #category : 'as yet unclassified' }
SecurityVisualizationHome >> gtHomeFor: aView [
	<gtHome>
	^ aView columnedList
		title: 'Security Visualization';
		items: #('Overview' 'About');
		column: 'Section' text: #yourself.
]
