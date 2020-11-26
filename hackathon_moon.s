
	  AREA appcode,CODE,READONLY
	 EXPORT __main
	 IMPORT printMsg
	 ;IMPORT printMsg2p
	 ;IMPORT printMsg4p
		 
    ENTRY 

__main  FUNCTION	  
	
TOTALLOOP		          MOV r5,#10           ; number of iterations      
		          VMOV.F32 S4,#1.0     ;        
				  
		          VMOV.F32 S3,#1.0
                  VLDR.F32 S21,=40.0                  
		          VMOV.F32 S2,#1.0  ; for factorial calculation           
		          VMOV.F32 S1,#1.0   ;just for multiplication of x^2              
		          VMOV.F32 S5,#1.0 ;just for multiplication of -x^2
				  VMOV.F32 S6,#2.0
				  VMOV.F32 S10,#1.0
				  VLDR.F32 S16,=0.5 
				  VADD.F32 S0,S16  ;input theta in radians
				  VLDR.F32 S17,=0.5
				  VADD.F32 S13,S17  ;radius
		     
				  
		      ;Caluclation of COSx
		
LOOP1	  VMUL.F32 S1,S1,S0 ;x
		  VMUL.F32 S1,S1,S0 ;x^2
		  VNMUL.F32 S1,S1,S5 ;-x^2
		  VDIV.F32 S1,S1,S2   ;-x^2/s2            
		  VADD.F32 S2,S2,s10  ;increment s2 by 1
		  VDIV.F32 S1,S1,S2  ;-x^2/((s2)*(s2+1)
		  VADD.F32 S3,S3,S1    ;1-x^2/2!  result is stored in s3          
		  VADD.F32 S2,S2,S4    ;s2+1		  
		  VMOV.F32 S11,S3		          ;COS OUTPUT
		  SUB r5,r5,#1                    ; output s3
		  CMP r5,#0    ;counting terms
		  BNE LOOP1
		  
		  ;VCVT.S32.F32 S3,S3
		  VMOV.F32 R0,S11     ;sending value to R0
		  ;BL printMsg       ;printing value
		  		
		  
		  MOV r5,#10    ; number of iterations 
		  
		  ;Calculation of SINx
		  VMOV.F S2,#2.0       ;for sin we need 3! in denominator
		  VMOV.F32 S1,S0       ;s1=x
		  VMOV.F32 S3,S0  ;s3=x
LOOP2	  VMUL.F32 S1,S1,S0   ;x^2            
		  VMUL.F32 S1,S1,S0 ;x^3
		  VNMUL.F32 S1,S1,S5 ;-x^3
		  VDIV.F32 S1,S1,S2       ;     -x^3/s2       
		  VADD.F32 S2,S2,s10
		  VDIV.F32 S1,S1,S2
		  VADD.F32 S3,S3,S1              
		  VADD.F32 S2,S2,S4 
          VMOV.F32 S12,S3         ;SIN OUTPUT		  
		  SUB r5,r5,#1                    
		  CMP r5,#0
		  BNE LOOP2  		  			
		  
		  VMOV.F32 R1,S12         ; move sin value to r1
		  		BL printMsg    ;print
				VLDR.F32 S20, = 6.3     ;2pi=6.28 so greater 6.3 the angle repeat in circle
				VCMP.F32 S0,S20     
				VMRS.F32		APSR_nzcv, FPSCR ;copying floating point registers in normal status registers
				BGT LOAD      ;load the theta to 0
				BLT VALUE
LOAD VLDR.F32   s0, = 0				
		        
				
VALUE		  VMUL.F32 S14,S11,S13 ;RCOS
              VADD.F32 S14,S21 ;A+RCOS
		  VMUL.F32 S15,S12,S13 ;RSIN
		  VADD.F32 S15,S21 ;B+RSIN
		   VMOV.F32 R0,S14
		    VMOV.F32 R1,S15
			BL printMsg
			
		  B TOTALLOOP
		  
		  
		  
stop    B stop                          ; stop program
     ENDFUNC
	 END
		 
