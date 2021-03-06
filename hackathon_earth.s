
	  AREA appcode,CODE,READONLY
	 EXPORT __main
	 IMPORT printMsg
	 ;IMPORT printMsg2p
	 ;IMPORT printMsg4p
		 
    ENTRY 

__main  FUNCTION	  
	
TOTALLOOP		          MOV r5,#10                      ;NUMBER OF TERMS TO TAKE IN EXPONENTIAL EXPANSION 
		          VMOV.F S4,#1.0;   ;;;
		          VMOV.F S3,#1.0                  
		          VMOV.F32 S2,#1.0             
		          VMOV.F S1,#1.0                 
		          VMOV.F S5,#1.0
				  VMOV.F S6,#2.0
				  VMOV.F S10,#1.0
				  VLDR.F32 S16,=0.9 
				  VADD.F32 S0,S16  ;INPUT THETA
				  VLDR.F32 S17,=0.9
				  VADD.F S13,S17  ;radius
		     
				  
		      ;Caluclation of COSx
		
LOOP1	  VMUL.F32 S1,S1,S0     ;
		  VMUL.F32 S1,S1,S0
		  VNMUL.F32 S1,S1,S5
		  VDIV.F32 S1,S1,S2               
		  VADD.F32 S2,S2,s10;;;
		  VDIV.F32 S1,S1,S2
		  VADD.F32 S3,S3,S1              
		  VADD.F32 S2,S2,S4   ;;;        
		  VMOV.F32 S11,S3		          ;COS OUTPUT
		  SUB r5,r5,#1                    ; output s3
		  CMP r5,#0
		  BNE LOOP1
		  
		  ;VCVT.S32.F32 S3,S3
		  ;VMOV.F32 R0,S11
		  ;BL printMsg
		  		;BL print
		  
		  MOV r5,#10    
		  
		  ;Calculation of SINx
		  VMOV.F S2,#2.0
		  VMOV.F32 S1,S0
		  VMOV.F32 S3,S0
LOOP2	          VMUL.F32 S1,S1,S0               
		  VMUL.F32 S1,S1,S0
		  VNMUL.F32 S1,S1,S5
		  VDIV.F32 S1,S1,S2               
		  VADD.F32 S2,S2,s10
		  VDIV.F32 S1,S1,S2
		  VADD.F32 S3,S3,S1              
		  VADD.F32 S2,S2,S4 
          VMOV.F32 S12,S3         ;SIN OUTPUT		  
		  SUB r5,r5,#1                    
		  CMP r5,#0
		  BNE LOOP2  		  			
		  ;BX lr
		  ;VMOV.F32 R1,S12
		  		;BL printMsg
				VLDR.F32 S20, = 6.3
				VCMP.F32 S0,S20
				VMRS.F32		APSR_nzcv, FPSCR
				BGT LOAD
				BLT VALUE
LOAD VLDR.F32   s0, = 0				
		  
VALUE		  VMUL.F32 S14,S11,S13 ;RCOS
		  VMUL.F32 S15,S12,S13 ;RSIN
		  B TOTALLOOP
		  
		  
		  
stop    B stop                          ; stop program
     ENDFUNC
	 END
		 
