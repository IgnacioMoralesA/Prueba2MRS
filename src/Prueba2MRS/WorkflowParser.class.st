Class {
	#name : 'WorkflowParser',
	#superclass : 'Object',
	#category : 'Prueba2MRS',
	#package : 'Prueba2MRS'
}

{ #category : 'as yet unclassified' }
WorkflowParser >> loadAllJSONFilesFrom: aDirectoryReference [
	| allJsonFiles dictionaries |
	
	allJsonFiles := aDirectoryReference allChildrenMatching: '*.json'.
	dictionaries := OrderedCollection new.

	allJsonFiles do: [ :file |
		[ dictionaries add: (self loadJSONFile: file) ]
			on: Error
			do: [ :ex |
				"Log y seguir con el resto"
				Transcript
					show: 'Error leyendo JSON: ';
					show: file basename;
					show: ' -> ';
					show: ex class name;
					cr ] ].

	^ dictionaries
]

{ #category : 'as yet unclassified' }
WorkflowParser >> loadJSONFile: aFileReference [
	| jsonString dictionary |
	
	[
		"Intento normal (texto UTF-8)"
		jsonString := aFileReference readStreamDo: [ :s | s contents ].
	] on: ZnInvalidUTF8 do: [ :ex |
		"Fallback: leer como binario y convertir 'lo mejor posible'"
		| bytes |
		bytes := aFileReference binaryReadStreamDo: [ :s | s contents ].
		jsonString := (ZnUTF8Encoder new decodeBytes: bytes).
	].

	dictionary := STONJSON fromString: jsonString.
	^ dictionary

]

{ #category : 'as yet unclassified' }
WorkflowParser >> parseFolder: dictionaries [
	| safe |
	safe := dictionaries ifNil: [ #() ].
	^ safe collect: [ :dict | self parseWorkflowFromFile: dict ]
]

{ #category : 'as yet unclassified' }
WorkflowParser >> parseWorkflowFromFile: dictionary [
    | workflowObj historyDict |
    
    workflowObj := Workflow new.
    
    workflowObj owner: (dictionary at: 'repo_owner' ifAbsent: [ '' ]).
    workflowObj repoName: (dictionary at: 'repo_name' ifAbsent: [ '' ]).
    workflowObj name: (dictionary at: 'workflow_name' ifAbsent: [ '' ]).
    
    "Obtener el diccionario con las versiones"
    historyDict := dictionary at: 'history' ifAbsent: [ Dictionary new ].
    
    historyDict keysAndValuesDo: [:date :data |
        | versionObj |
        versionObj := Version new.
        versionObj date: date.
        
        (data at: 'vulnerability_list' ifAbsent: [ #() ]) do: [:vulDict |
            | vulnObj |
            vulnObj := Vulnerability new.
            
            vulnObj ruleId: (vulDict at: 'ruleId' ifAbsent: [ '' ]).
            vulnObj level: (vulDict at: 'level' ifAbsent: [ '' ]).
            vulnObj message: (
                (vulDict at: 'message' ifAbsent: [ Dictionary new ])
                    at: 'text'
                    ifAbsent: [ '' ]
            ).
            
            versionObj addVulnerability: vulnObj.
        ].
        
        workflowObj addVersion: versionObj.
    ].
    
    ^ workflowObj

]
