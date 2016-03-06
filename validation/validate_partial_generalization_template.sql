<COMMENT>
CREATE OR REPLACE TRIGGER val_partial_gen_<VAL_PARTIAL_GEN_NAME>
   BEFORE INSERT OR UPDATE ON <SUPERCLASS_TABLE_NAME>
   REFERENCING NEW AS NEW OLD AS OLD
   FOR EACH ROW
DECLARE
   n NUMBER;
BEGIN
   SELECT count(*) INTO n
      FROM <SUBCLASSES_TABLE_NAMES>
      WHERE <PARTIAL_CONDITION>;
   
   IF (n >= 1 AND :NEW.geom is not null) THEN
   	  RAISE_APPLICATION_ERROR(-20001, 'Partial constraint of generalization on table <SUPERCLASS_TABLE_NAME> <SUPERCLASS_TABLE_KEYS>is violated');
   END IF;
END;
/