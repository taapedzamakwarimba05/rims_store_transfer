PROCEDURE GENERATE_SUPPLY_RIMS_STORE IS

SET sqlformat csv
set headsep on
set echo off
set sqlprompt ' '
set linesize 300
set pages 10000
set space 0
set newpage 2
set termout off
set showmode off
set echo off
set head off
set colsep 
set message off
set verify off
set trimspool on
set numwidth 10

spool c:\temp\RIMS.dat

SELECT rm_no||substr(trans_no,1,4)||'50000'||item_no||'  '||store_no||
	SUBSTR((tstock+100000),2,5)||SUBSTR((DECODE(s1,NULL,0,s1)+10000),3,4)
	||SUBSTR((DECODE(s2,NULL,0,s2)+10000),3,4)||SUBSTR((DECODE(s3,NULL,0,s3)+10000),3,4) 
	||SUBSTR((DECODE(s4,NULL,0,s4)+10000),3,4)||SUBSTR((DECODE(s5,NULL,0,s5)+10000),3,4)
	||SUBSTR((DECODE(s6,NULL,0,s6)+10000),3,4)||SUBSTR((DECODE(s7,NULL,0,s7)+10000),3,4) 
	||SUBSTR((DECODE(s8,NULL,0,s8)+10000),3,4)||SUBSTR((DECODE(s9,NULL,0,s9)+10000),3,4)
	||SUBSTR((DECODE(s10,NULL,0,s10)+10000),3,4)||SUBSTR((DECODE(s11,NULL,0,s11)+10000),3,4)
	||SUBSTR((DECODE(s12,NULL,0,s12)+10000),3,4)||SUBSTR((DECODE(s13,NULL,0,s13)+10000),3,4)||TRANS_NO
	FROM STORE_STK_RIMS; 
spool off 
--select 	h.from_whse,h.week_no,h.trans_no,h.to_whse,s.item_no,s.width,s.size_display,s.released_qty
--from whs_trans_hdr h,whs_trans_size s
exit
end;