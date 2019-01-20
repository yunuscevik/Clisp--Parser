;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;     141044080 YUNUS CEVIK   ;;;
;;;          PARSE TREE         ;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


; Deneme amacli ornek Token Listeleri
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defvar sampleTokenList '(
("operator" "(") ("keyword" "deffun") ("identifier" "check_coord") 
	("operator" "(") ("identifier" "x") ("identifier" "y") ("operator" ")")
 	("operator" "(") ("keyword" "if") 
	 	("operator" "(") ("keyword" "and") 
		 	("operator" "(") ("keyword" "equal") ("identifier" "x") ("integer" "1") ("operator" ")")
		 	("operator" "(") ("keyword" "equal") ("identifier" "y") ("integer" "2") ("operator" ")")
		("operator" ")") ("integer" "1") ("integer" "0")
	("operator" ")")
("operator" ")")

))
(defvar sampleTokenList1 '(
	("operator" "(") ("keyword" "concat")
 	("operator" "'(") ("integer" "1")
 ("integer" "2") ("integer" "3") ("integer" "4") ("operator" ")") ("integer" "3") ("operator" ")")
))
(defvar sampleTokenList2 '(
("operator" "(") ("keyword" "deffun") ("identifier" "topla") ("operator" "(")
 ("identifier" "Q") ("operator" ")") ("operator" "(") ("integer" "1")
 ("integer" "2") ("integer" "3") ("integer" "4") ("operator" ")") ("identifier" "Q")
 ("operator" ")")
))

(defvar sampleTokenList3 '(
("operator" "(") ("keyword" "deffun") ("identifier" "topla") ("operator" "(")
 ("identifier" "Q") ("operator" ")") ("operator" "'(") ("integer" "1")
 ("integer" "2") ("integer" "3") ("integer" "4") ("operator" ")") ("identifier" "Q")
 ("operator" ")")
))

(defvar sampleTokenList4 '(
("operator" "(") 
("keyword" "deffun") ("identifier" "sumup") 
("operator" "(") ("identifier" "x") ("operator" ")") 
	("operator" "(") ("keyword" "if") ("operator" "(") ("keyword" "equal") ("identifier" "x") ("integer" "0") ("operator" ")") 
		("integer" "1") 
		("operator" "(") ("operator" "+") ("identifier" "x") ("operator" "(") ("identifier" "sumup") ("operator" "(") ("operator" "-") ("identifier" "x") ("integer" "1") ("operator" ")") ("operator" ")") ("operator" ")") 

	("operator" ")") 
("operator" ")")

))


(defvar sampleTokenList5 '(
("operator" "(") ("keyword" "deffun") ("identifier" "sumup") 
("operator" "(") ("identifier" "x") ("identifier" "y") ("identifier" "z") ("operator" ")") ("operator" "(") 
	("keyword" "if") ("operator" "(") ("keyword" "equal") ("identifier" "x") ("integer" "0") ("operator" ")") 
		("integer" "1") 
		("operator" "(") ("operator" "+") ("identifier" "x") ("operator" "(") ("identifier" "sumup") ("operator" "(") ("operator" "-") ("identifier" "x") ("integer" "1") ("operator" ")") ("operator" ")") ("operator" ")") 
	("operator" ")") 
("operator" ")")
))


(defvar sampleTokenList6 '(
	("operator" "(") ("keyword" "if") ("operator" "(") ("keyword" "equal") ("identifier" "x") ("integer" "0") ("operator" ")")
		("operator" "(") ("keyword" "concat")
	 	("operator" "'(") ("integer" "1")
	 	("integer" "2") ("integer" "3") ("integer" "4") ("operator" ")") ("keyword" "()") 
	 	("operator" ")")
	

))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defvar RULES '(
	("'(" "VALUES" ")")
	("ID" "EXPLISTI")
	"ID" "VALUES "
	("set" "ID" "EXPI") 
	("+" "EXPI" "EXPI") 
	("-" "EXPI" "EXPI") 
	("*" "EXPI" "EXPI") 
	("/" "EXPI" "EXPI") 
	("deffun" "ID" "IDLIST" "EXPLISTI") 
	("defvar" "ID" "EXPI") 
	("set" "ID" "EXPI") 
	("if" "EXPB" "EXPLISTI" "EXPLISTI") 
	("if" "EXPB" "EXPLISTI") 
	("while" "(" "EXPB" ")" "EXPLISTI") 
	("for" "(" "ID" "EXPI" "EXPI" ")" "EXPLISTI") 
	"BinaryValue" 
	("and" "EXPB" "EXPB") 
	("or" "EXPB" "EXPB") 
	("not" "EXPB") 
	("equal" "EXPI" "EXPI") 
	("equal" "EXPB" "EXPB") 
	"EXPI"
	("concat" "EXPLISTI" "EXPLISTI") 
	("append" "EXPI" "EXPLISTI") 
	"null" 
	"integer"
	"IDLIST" 
	"keyword"
	"()"
))

; Fonksiyonun baslangic ve bitis parantezlerini belirler 
(defun countBracket(bracketList bracketCheck)
	(setq bracket (car bracketList))
	(if (equal bracket nil)
		0
		(if (or (equal(car (cdr bracket)) "(") (equal(car (cdr bracket)) "'("))
			(+ 1 (countBracket (cdr bracketList) (+ 1 bracketCheck)))
			(if (equal(car (cdr bracket)) ")")
				(if (= (- bracketCheck 1) 0)
					1
					(+ 1 (countBracket (cdr bracketList) (- bracketCheck 1)))
				)
				(+ 1 (countBracket (cdr bracketList) bracketCheck))
			)
		)
	)
)


; Dosyaya ekleyerek yazma islemini gerceklestirir.
(defun writeFile (writeString fileName)
	(with-open-file (str fileName
	                     :direction :output
	                     :if-exists :append    ;supersede   ;overwrite
	                     :if-does-not-exist :create)
	  	(format str writeString))
)

; Terminal ekraninda hem cikti saglayip hemde recursive olarak calisan bu fonksiton ile dosyaya yazma islemi gerceklestiriliyor
(defun printAndWriteFileTree (tree fileName &optional (tabSpace ""))
	(if (null tree)
		nil
		(progn
			(if (listp (car tree))
				(printAndWriteFileTree (car tree) fileName tabSpace)
				(progn
					(write-line "")
					(writeFile (string #\NewLine) fileName)
					(write-string tabSpace)
					(writeFile tabSpace fileName)
					(write-string (car tree))
					(writeFile (string (car tree)) fileName)
					(setq tabSpace (concatenate 'string tabSpace (string #\Tab)))
				)
			)
			(printAndWriteFileTree (cdr tree) fileName tabSpace)
		)
	)
)


; Hangi Token'in hangi kurala uydugunu buluyor  (+ 4 5)  -> (+ EXPI EXPI)
(defun checkRule(checkliste ruleList) 
	(setq rule (car ruleList))
	(if (not rule)
		nil
		(if (listp rule)
			(if (equal (car rule) (car (cdr (car checkliste))))
				rule
				(checkRule checkliste (cdr ruleList))
			)
			(if (equal rule (car (cdr (car checkliste))))
				rule
				(checkRule checkliste (cdr ruleList))
			)
		)
	)	
)

; Gelen token kurallar listesinde liste seklinde mi yoksa string seklinde mi kontrol ediyor
(defun checkNotList(cnlliste cnlstring)
	(setq item (car cnlliste))
	(if (equal item nil)
		nil
		(if (listp item)
			(checkNotList (cdr cnlliste) cnlstring)
			(if (equal item cnlstring)
				t
				(checkNotList (cdr cnlliste) cnlstring)
			)
		)
	)
)

; Parse Tree olusturmak icin oncelikle Parse Tree Listesi olusturmak icin olusturulmus fonksiyon
; tokenList -> Gelen tokenleri kurala uygun bir sekilde Parse Tree Listesine koyuyor
; rule -> Tokenlerin hangi kurala uygun oldugu tespit edilip o kuralin parametre olarak verilmesi
(defun generateListForTree(tokList rule &optional (parseTreeList '()))
	(if (or (equal (car (cdr (car tokList))) "(" ) (equal (car (cdr (car tokList))) "'(" ) )
		(progn
			(if (equal "null" rule)
				(append parseTreeList (generateListForTree (subseq tokList (countBracket tokList 0) (length tokList)) rule  (Main  (cdr tokList) '("null"))))
				(if (equal "IDLIST" (car rule))
					(append parseTreeList (generateListForTree (subseq tokList (countBracket tokList 0) (length tokList)) (cdr rule) (list (Main tokList '("IDLIST")))))
					(if (equal "EXPLISTI" (car rule))
						(append parseTreeList (generateListForTree (subseq tokList (countBracket tokList 0) (length tokList)) (cdr rule) (list (Main  tokList '("EXPLISTI")))))
						(if (equal "EXPB" (car rule))
							(append parseTreeList (generateListForTree (subseq tokList (countBracket tokList 0) (length tokList)) (cdr rule) (list (Main  tokList '("EXPB")))))
							(if (and (equal "VALUES" (car rule)) (equal (car (cdr (car tokList))) "'(" ))
								(append parseTreeList (generateListForTree (subseq tokList (countBracket tokList 0) (length tokList)) (cdr rule) (list (Main  tokList  '("VALUES")))))
								(if (equal "EXPI" (car rule))
									(append parseTreeList (generateListForTree (subseq tokList (countBracket tokList 0) (length tokList)) (cdr rule) (list (Main  tokList '("EXPI")))))
									(append parseTreeList (generateListForTree (cdr tokList) rule (list (cdr (car tokList)))))	
								)
							)

						)
					)
				)
			)
		)
		(if (not (car tokList))
			parseTreeList
			(if (checkNotList RULES (car (car tokList)))
				(progn
					(if (equal "EXPLISTI" (car rule))
						(progn
							(if (equal "integer" (car (car tokList)))
								(append parseTreeList (generateListForTree (cdr tokList) (cdr rule) (list (append '("EXPLISTI") (list (append '("EXPI") (list (append '("VALUES") (list (append '("IntegetValue") (list (cdr (car tokList))))))))) ))))
								(append parseTreeList (generateListForTree (cdr tokList) (cdr rule) (list (append '("EXPLISTI") (list (cdr (car tokList))) ))))
							)
						)

						(if (equal "EXPB" (car rule))
							(append parseTreeList (generateListForTree (cdr tokList) (cdr rule) (list (append '("EXPB") (list (cdr (car tokList))) ))))
							(if (equal "integer" (car (car tokList)))
								(append parseTreeList (generateListForTree (cdr tokList) (cdr rule) (list (append '("EXPI") (list (append '("VALUES") (list (append '("IntegetValue") (list (cdr (car tokList))))))) ))))
								(append parseTreeList (generateListForTree (cdr tokList) (cdr rule) (list (cdr (car tokList)))))
							)
							
						)
					)
				)
				(progn
					(if (equal "identifier" (car (car tokList)))
						(progn
							(if (equal "identifier" (car (car (cdr tokList))))
								(progn
									(append parseTreeList (append (list (append  '("ID") (list (cdr (car tokList))))) 
										(list (generateListForTree (subseq tokList (countBracket (cdr tokList) 0) (- (length tokList) 1)) (cdr rule)  (Main  (cdr tokList) '("IDLIST"))))))
								)
								(if (equal "EXPI" (car rule))
									(append parseTreeList (generateListForTree (cdr tokList) (cdr rule) (list (append '("EXPI") (list (append '("ID") (list (cdr (car tokList))))) ))))
									(if (and (equal "(" (car (cdr (car (cdr tokList))))) (string/= "IDLIST" (car (cdr rule))))
										(progn
											(append parseTreeList (list (append  '("ID") (list (cdr (car tokList))))) )
											(append parseTreeList (append (list (append  '("ID") (list (cdr (car tokList))))) 
												(list (generateListForTree (subseq tokList (countBracket (cdr tokList) 0) (- (length tokList) 1)) (cdr rule) (list (Main  (cdr tokList) '("EXPLISTI")))))))
										)
										(append parseTreeList (generateListForTree (cdr tokList) (cdr rule) (list (append '("ID") (list (cdr (car tokList))) ))))
									)
								)
							)
						)
						(if (equal "EXPLISTI" (car rule))
							(append parseTreeList (generateListForTree (cdr tokList) (cdr rule) (list (append '("EXPLISTI") (list (cdr (car tokList))) ))))
							(if (equal "EXPI" (car rule))
								(append parseTreeList (generateListForTree (cdr tokList) (cdr rule) (list  (append '("EXPI") (list (cdr (car tokList))) ))))
								(append parseTreeList (generateListForTree (cdr tokList) (cdr rule) (append (list (cdr (car tokList))) )))
								
							)
						)
						
					)

					
				)
			)
		)
	)
)

(defun Main(tokenList &optional (pTree '("EXPI")))
	(setq bound (countBracket tokenList 0))
	(if (equal (car pTree) "null")
		(progn
			(setq pTree (append '(("(")) (list(append pTree (generateListForTree (subseq tokenList 1 (- bound 1)) (checkRule (subseq tokenList 1 (- bound 1)) RULES))))))
			(setq pTree (append pTree '((")"))))
		)
		(if (equal (car pTree) "IDLIST")
			(progn
				(setq pTree (append pTree '(("("))))			
				(setq pTree (append pTree (list (append '("IDLIST") (generateListForTree (subseq tokenList 0 bound) (checkRule (subseq tokenList 1 (- bound 1)) RULES))))))
				(setq pTree (append pTree '((")"))))
			)
			(if (and (equal (car pTree) "EXPLISTI") (equal (car (cdr (car tokenList))) "'("))
				(progn
					(setq pTree (append pTree '(("'("))))			
					(setq setValues '("VALUES"))
					(setq pTree (append pTree (generateListForTree (subseq tokenList 0 bound) setValues)))
					(setq pTree (append pTree '((")"))))
				)
				(if (equal (car pTree) "VALUES")
					(progn
						(setq setValues '("VALUES"))
						(setq pTree (append pTree (generateListForTree (subseq tokenList 2 (- bound 1)) setValues)))
						
					)
					(if (and (equal (car pTree) "EXPLISTI") (equal (car (car (subseq tokenList 1 bound))) "keyword"))
						(progn
							;(setq pTree (append pTree '(("("))))
							(setq pTree (append pTree (list (append '("EXPI") (generateListForTree (subseq tokenList 0 bound) (checkRule (subseq tokenList 1 (- bound 1)) RULES))))))
							;(setq pTree (append pTree '((")"))))
						)
						(if (and (equal (car pTree) "EXPLISTI") (and (car (cdr (car (cdr (subseq tokenList 0 bound))))) (car (checkRule (subseq tokenList 1 (- bound 1)) RULES))))
							(setq pTree (append pTree (list (append '("EXPI") (generateListForTree (subseq tokenList 0 bound) (checkRule (subseq tokenList 1 (- bound 1)) RULES))))))
							(setq pTree (append pTree (generateListForTree (subseq tokenList 0 bound) (checkRule (subseq tokenList 1 (- bound 1)) RULES))))
						)
					)
				)
			)
		)
	)
)

(defun parser(TokenList)

	(setq parseTreeList (Main TokenList))
	(setq parseTreeList (append '("INPUT") (list parseTreeList)))
	(setq parseTreeList (append '("START") (list parseTreeList)))
	;(write parseTreeList)
	;(write-line "")
	(delete-file "141044080.tree")
	(setq formatType "; DIRECTIVE: parse tree ")
	(setq formatType (concatenate 'string formatType (string #\NewLine)))
	(setq formatType (concatenate 'string formatType (string #\NewLine)))
	(writeFile formatType "141044080.tree")
	(printAndWriteFileTree parseTreeList "141044080.tree")
)


;(parser sampleTokenList4)





