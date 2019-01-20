# Clisp--Parser

### ---> Project => [Project2](../master/Project2.pdf)

Sample-TokenList:

(defvar sampleTokenList '(("operator" "(") ("keyword" "deffun") ("identifier" "sumup") ("operator" "(") ("identifier" "x") ("operator" ")") ("operator" "(") ("keyword" "if") ("operator" "(") ("keyword" "equal") ("identifier" "x") ("integer" "0") ("operator" ")") ("integer" "1") ("operator" "(") ("operator" "+") ("identifier" "x") ("operator" "(") ("identifier" "sumup") ("operator" "(") ("operator" "-") ("identifier" "x") ("integer" "1") ("operator" ")") ("operator" ")") ("operator" ")") ("operator" ")") ("operator" ")")))

Sample-TokenList-Output-ParseTree:


START

	INPUT
	
		EXPI
		
			(
			
			deffun
			
			ID
			
				sumup
				
			IDLIST
			
				(
				
				IDLIST
				
					(
					
					ID
					
						x
						
					)
					
				)
				
			EXPLISTI
			
				EXPI
				
					(
					
					if
					
					EXPB
					
						(
						
						equal
						
						EXPI
						
							ID
							
								x
								
						EXPI
						
							VALUES
							
								IntegetValue
								
									0
									
						)
						
					EXPLISTI
					
						EXPI
						
							VALUES
							
								IntegetValue
								
									1
									
					EXPLISTI
					
						EXPI
						
							(
							
							+
							
							EXPI
							
								ID
								
									x
									
							EXPI
							
								(
								
								ID
								
									sumup
									
								EXPLISTI
								
									EXPI
									
										(
										
										-
										
										EXPI
										
											ID
											
												x
												
										EXPI
										
											VALUES
											
												IntegetValue
												
													1
													
										)
										
								)
								
							)
							
					)
					
			)
			
