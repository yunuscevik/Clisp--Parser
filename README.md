# Clisp--Parser




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
			
