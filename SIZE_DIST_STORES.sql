PROCEDURE generate_size_dist is 

BEGIN 

Declare

CURSOR supplies_tostores_FTWR IS 

SELECT A2.STORE_NO STORE_NO,substr(A1.ITEM_NO, 1, 7) ITEM,'00' WIDTH,A1.SIZE_DISPLAY SIZE_DISPLAY,nvl(A1.RELEASED_QTY, 0)PAIRS,CONCAT(substr(A1.ITEM_NO, 1, 1) , A1.SIZE_DISPLAY) SIZE_GRP
FROM
    WHS_TRANS_HDR A4,
    WHS_TRANS_ITEM A3,
    STORE         A2,
    WHS_TRANS_SIZE   A1
WHERE
     A4.TRANS_NO = A3.TRANS_NO
    AND A3.TRANS_NO = A1.TRANS_NO
    AND A2.STORE_NO = A4.TO_WHSE
    AND A4.TO_WHSE = A3.STORE_NO
    AND A4.FROM_WHSE = A3.FROM_WHSE
    AND A3.FROM_WHSE = A1.FROM_WHSE
    AND A4.FROM_WHSE <> '10'
    AND A4.TRANS_TYPE = A3.TRANS_TYPE
    AND A3.TRANS_TYPE = A1.TRANS_TYPE
    AND A3.ITEM_NO = A1.ITEM_NO
    AND A3.WIDTH = A1.WIDTH
    AND A1.WIDTH = '00'
    AND ( A2.DEPT_NO = '500'
          OR A2.DEPT_NO = '501'
          OR A2.DEPT_NO = '502' )
    AND A4.WHO_REQ <> 'AUTORESUPP'
    AND A4.TRANS_HDR_STATUS <> 'C'
GROUP BY
    A2.STORE_NO, A1.ITEM_NO, A1.SIZE_DISPLAY, '00', nvl(A1.RELEASED_QTY, 0);


--SUPPLIES
--DISTRIBUTE SIZES
--NON-FOOTWEAR
 
CURSOR  supplies_tostores_NONFTWR IS

SELECT A2.STORE_NO STORE_NO,substr(A1.ITEM_NO, 2, 8) ITEM,'CL' WIDTH,A1.SIZE_DISPLAY SIZE_DISPLAY,SUM(nvl(A1.RELEASED_QTY, 0)) PAIRS, substr(A1.ITEM_NO, 1, 2) SIZE_GRP
FROM
    WHS_TRANS_HDR A4,
    WHS_TRANS_ITEM A3,
    STORE         A2,
    WHS_TRANS_SIZE   A1
WHERE
     A4.TRANS_NO = A3.TRANS_NO
    AND A3.TRANS_NO = A1.TRANS_NO
    AND A2.STORE_NO = A4.TO_WHSE
    AND A4.TO_WHSE = A3.STORE_NO
    AND A4.FROM_WHSE = A3.FROM_WHSE
    AND A3.FROM_WHSE = A1.FROM_WHSE
    AND A4.FROM_WHSE <> '10'
    AND A4.TRANS_TYPE = A3.TRANS_TYPE
    AND A3.TRANS_TYPE = A1.TRANS_TYPE
    AND A3.ITEM_NO = A1.ITEM_NO
    AND A3.WIDTH = A1.WIDTH
    AND A1.WIDTH = '00'
    AND ( A2.DEPT_NO = '500'
          OR A2.DEPT_NO = '501'
          OR A2.DEPT_NO = '502' )
    AND A4.WHO_REQ <> 'AUTORESUPP'
    AND A4.TRANS_HDR_STATUS <> 'C'
GROUP BY
    A2.STORE_NO, A1.ITEM_NO, A1.SIZE_DISPLAY, 'CL';


BEGIN

--DISTRIBUTE SIZES FOR FOOTWEAR 
FOR rec IN supplies_tostores_FTWR LOOP

IF (REC.SIZE_GRP = '0020' OR REC.SIZE_GRP = '1020' OR REC.SIZE_GRP ='2020'OR REC.SIZE_GRP='3090' OR REC.SIZE_GRP='4020'OR REC.SIZE_GRP='5020'OR REC.SIZE_GRP='6020'OR REC.SIZE_GRP='7020' OR REC.SIZE_GRP='8050') THEN
UPDATE STORE_STK_RIMS
SET s1 = nvl(rec.pairs,0)
WHERE store_no = rec.store_no
AND   item_no  = rec.ITEM
AND   width    = rec.width
AND RM_NO = 'RM63';

ELSIF ( REC.SIZE_GRP = '0030' OR REC.SIZE_GRP='1030'OR REC.SIZE_GRP='2030'OR REC.SIZE_GRP='3100'OR REC.SIZE_GRP='4030'OR REC.SIZE_GRP='5030'OR REC.SIZE_GRP='6030'OR REC.SIZE_GRP='7030' OR REC.SIZE_GRP='8060')THEN
UPDATE STORE_STK_RIMS
SET s2 = nvl(rec.pairs,0)
WHERE store_no = rec.store_no
AND   item_no  = rec.ITEM
AND   width    = rec.width
AND RM_NO = 'RM63';

ELSIF REC.SIZE_GRP IN ('0040','1040','2040','3110','4040','5040','6040','7040','8070')THEN
UPDATE STORE_STK_RIMS
SET s3 = nvl(rec.pairs,0)
WHERE store_no = rec.store_no
AND   item_no  = rec.ITEM
AND   width    = rec.width
AND RM_NO = 'RM63';

ELSIF REC.SIZE_GRP IN ('0050','1050','2050','3120','4050','5050','6050','7050','8080')THEN
UPDATE STORE_STK_RIMS
SET s4 = nvl(rec.pairs,0)
WHERE store_no = rec.store_no
AND   item_no  = rec.ITEM
AND   width    = rec.width
AND RM_NO = 'RM63';

ELSIF REC.SIZE_GRP IN ('0060','1060','2060','3130','4060','5060','6060','7060','8090')THEN
UPDATE STORE_STK_RIMS
SET s5 = nvl(rec.pairs,0)
WHERE store_no = rec.store_no
AND   item_no  = rec.ITEM
AND   width    = rec.width
AND RM_NO = 'RM63';

ELSIF REC.SIZE_GRP IN ('0070','1070','2070','3010','4070','5070','6070','7070','8100')THEN
UPDATE STORE_STK_RIMS
SET s6 = nvl(rec.pairs,0)
WHERE store_no = rec.store_no
AND   item_no  = rec.ITEM
AND   width    = rec.width
AND RM_NO = 'RM63';

ELSIF REC.SIZE_GRP IN ('0080','1080','2080','3020','4080','5080','6080','7080','8110')THEN
UPDATE STORE_STK_RIMS
SET s7 = nvl(rec.pairs,0)
WHERE store_no = rec.store_no
AND   item_no  = rec.ITEM
AND   width    = rec.width
AND RM_NO = 'RM63';

ELSIF REC.SIZE_GRP IN ('0090','1090','2090','3030','4090','5090','6090','7090','8120')THEN
UPDATE STORE_STK_RIMS
SET s8 = nvl(rec.pairs,0)
WHERE store_no = rec.store_no
AND   item_no  = rec.ITEM
AND   width    = rec.width
AND RM_NO = 'RM63';

ELSIF REC.SIZE_GRP IN ('0100','1100','2100','3040','4100','5100','6100','7100','8130')THEN
UPDATE STORE_STK_RIMS
SET s9 = nvl(rec.pairs,0)
WHERE store_no = rec.store_no
AND   item_no  = rec.ITEM
AND   width    = rec.width
AND RM_NO = 'RM63';

ELSIF REC.SIZE_GRP IN ('0110','1110','2110','4110','5110','6110','7110','8140')THEN
UPDATE STORE_STK_RIMS
SET s10 = nvl(rec.pairs,0)
WHERE store_no = rec.store_no
AND   item_no  = rec.ITEM
AND   width    = rec.width
AND RM_NO = 'RM63';

ELSIF REC.SIZE_GRP IN ('0120','1120','2120','8150')THEN
UPDATE STORE_STK_RIMS
SET s11 = nvl(rec.pairs,0)
WHERE store_no = rec.store_no
AND   item_no  = rec.ITEM
AND   width    = rec.width
AND RM_NO = 'RM63';

ELSIF REC.SIZE_GRP IN ('0130','1130','2130','8160')THEN
UPDATE STORE_STK_RIMS
SET s12 = nvl(rec.pairs,0)
WHERE store_no = rec.store_no
AND   item_no  = rec.ITEM
AND   width    = rec.width
AND RM_NO = 'RM63';
END IF;
END LOOP;
COMMIT;

--DISTRIBUTE SIZES FOR NON FOOTWEAR

FOR rec IN supplies_tostores_NONFTWR LOOP


IF REC.SIZE_GRP IN ('09')THEN
UPDATE STORE_STK_RIMS
SET s1 = nvl(rec.pairs,0)
WHERE store_no = rec.store_no
AND   item_no  = rec.ITEM
AND   width    = rec.width
AND RM_NO = 'RM63';
/*
ELSIF REC.SIZE_GRP IN ('0XS')THEN
UPDATE STORE_STK_RIMS
SET s2 = nvl(rec.pairs,0)
WHERE store_no = rec.store_no
AND   item_no  = rec.ITEM
AND   width    = rec.width
AND RM_NO = 'RM63';

ELSIF REC.SIZE_GRP IN ('0S')THEN
UPDATE STORE_STK_RIMS
SET s3 = nvl(rec.pairs,0)
WHERE store_no = rec.store_no
AND   item_no  = rec.ITEM
AND   width    = rec.width
AND RM_NO = 'RM63';

ELSIF REC.SIZE_GRP IN ('0M')THEN
UPDATE STORE_STK_RIMS
SET s4 = nvl(rec.pairs,0)
WHERE store_no = rec.store_no
AND   item_no  = rec.ITEM
AND   width    = rec.width
AND RM_NO = 'RM63';

ELSIF REC.SIZE_GRP IN ('0L')THEN
UPDATE STORE_STK_RIMS
SET s5 = nvl(rec.pairs,0)
WHERE store_no = rec.store_no
AND   item_no  = rec.ITEM
AND   width    = rec.width
AND RM_NO = 'RM63';

ELSIF REC.SIZE_GRP IN ('0XL')THEN
UPDATE STORE_STK_RIMS
SET s6 = nvl(rec.pairs,0)
WHERE store_no = rec.store_no
AND   item_no  = rec.ITEM
AND   width    = rec.width
AND RM_NO = 'RM63';

ELSIF REC.SIZE_GRP IN ('0XXL')THEN
UPDATE STORE_STK_RIMS
SET s7 = nvl(rec.pairs,0)
WHERE store_no = rec.store_no
AND   item_no  = rec.ITEM
AND   width    = rec.width
AND RM_NO = 'RM63';
*/

END IF;
END LOOP;
COMMIT;
END;
End;