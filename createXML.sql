CREATE OR REPLACE DIRECTORY XML_EDI_FILES AS 'C:\Users\Marcos\Documents';
set serveroutput on;
declare
	ctx DBMS_XMLGEN.ctxhandle;
	xmlr clob;
begin
	ctx := DBMS_XMLGEN.newContext('SELECT E.numero, E.chefe.cpf AS CPF_Chefe, E.chefe.nome AS Nome_Chefe, E.data FROM tb_edicao E ORDER BY E.numero');
	DBMS_XMLGEN.setRowsetTag(ctx, 'EDICOES');
	DBMS_XMLGEN.setRowTag(ctx, 'EDICAO');
	xmlr := DBMS_XMLGEN.getXML(ctx);
	DBMS_XSLPROCESSOR.CLOB2FILE(xmlr ,'XML_EDI_FILES' ,'edicoes.xml');
	DBMS_XMLGEN.closeContext(ctx);
end;
/