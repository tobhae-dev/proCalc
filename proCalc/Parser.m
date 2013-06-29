//
//  Parser.m
//  proCalc
//
//  Created by Jonas on 6/13/13.
//  Copyright (c) 2013 jonatobi. All rights reserved.
//

#import "Parser.h"

@implementation Parser

-(double) ParseNumber
{
    NSString *numberTemp=@"";
    int c = 0;
    int i=0;

    for (i=0; (i < funktion.length && (([funktion characterAtIndex:i] >= '0' && [funktion characterAtIndex:i] <= '9') | ([funktion characterAtIndex:i]=='.'))); i++)
    {
            numberTemp = [NSString stringWithFormat:@"%@%c", numberTemp,[funktion characterAtIndex:i]];
            c++;
    }
    funktion =[funktion substringFromIndex:c];
    
    return [numberTemp doubleValue];
}

- (double) ParseExpr
{
    double op , op1;
    op=[self ParseFactor];
    if (funktion.length!= 0 )
    {
        if ([funktion characterAtIndex:0]== '+')
        {
            funktion =[funktion substringFromIndex:1];         
            op1=[self ParseExpr];
            op += op1;
        }
        else if ([funktion characterAtIndex:0]=='-')
        {
            funktion =[funktion substringFromIndex:1];
            op1= [self ParseExpr];
            op -= op1;
        }
    }
    return op;
}

- (double) ParseTerm
{
    double returnValue = 0;
    if (funktion.length != 0)
    {
        char character= [funktion characterAtIndex:0];
        if (character >= '0' && character <= '9')
        {
            returnValue=[self ParseNumber];
            return returnValue;
        }
        else if ([funktion characterAtIndex:0]== '(')
        {
            funktion =[funktion substringFromIndex:1];
            returnValue=[self ParseExpr];
            funktion =[funktion substringFromIndex:1];
            return returnValue;
        }
    }
    return returnValue;
}


- (double) ParseFactor
{
    double op, op1;
    op=[ self ParseTerm];

    if (funktion.length != 0)
    {
        if ([funktion characterAtIndex:0]== '*')
        {
            funktion =[funktion substringFromIndex:1];
            op1=[self ParseFactor];
            op *= op1;
        }
        else if ([funktion characterAtIndex:0] == '/')
        {
            funktion =[funktion substringFromIndex:1];
            op1=[ self ParseFactor];
            op /= op1;
        }
    }
    return op;
}


//berechnen der potenz und erstezen
-(void) potenz
{
    int i=0;
    int x=0;
    int y=0;
    int anzahl=0;   //anzahl der potenzen
    int klammern=1; //anzahl der klammern
    
    NSString *hochzahl=@""; //zahl die oben steht
    NSString *untenzahl=@""; //zahl die unten steht
    double ergebniss=0;
    double oben=0;  //wert fuer oben
    double unten=0; //wert fuer unten
    
    
    //suche nach den Potenzen
    while (i < funktion.length ) 
    {
        if([funktion characterAtIndex:i]=='^'){
            anzahl++;
        }
        i++;
    }
    //so oft potenzen vorkommen
    for(int t=anzahl;t>0;t--){
        i=0;
        x=0;
        y=0;
        ergebniss=0;
        oben=0;
        unten=0;
        hochzahl=@"";
        untenzahl=@"";
      
    //nach stelle der potenz suchen
    while ((i < funktion.length ) && ([funktion characterAtIndex:i]!='^'))
    {
        i++;
    }
     
    //trennung ob einzelne zahl oder teilfunktion
    if([funktion characterAtIndex:i+1] >= '0' && [funktion characterAtIndex:i+1] <= '9'){
    
        for (int c=i+1; (c < funktion.length && (([funktion characterAtIndex:c] >= '0' && [funktion characterAtIndex:c] <= '9')| ([funktion characterAtIndex:c]=='.'))); c++)
    {
        hochzahl = [NSString stringWithFormat:@"%@%c", hochzahl,[funktion characterAtIndex:c]];
        x=c;
    }
        oben= [hochzahl doubleValue];
    }
    //teilfunktion
    else{
        for (int c=i+2; (c < funktion.length) & (klammern>0); c++)
        {

            if([funktion characterAtIndex:c]=='('){
                klammern++;
            }
            if([funktion characterAtIndex:c]==')'){
                klammern--;
            }
            //teilfunktion
            hochzahl = [NSString stringWithFormat:@"%@%c", hochzahl,[funktion characterAtIndex:c]];
            x=c;
        }
        hochzahl=[hochzahl substringToIndex:hochzahl.length-1];
        Parser *bla=[[Parser alloc] init];
        //mithilfe des parser teilfunktion berechnen lassen
        oben=[bla xReplace:hochzahl xwert:(@"1")];
 
    }
        
        klammern=1;
       //unten zahl wie oben zahl
    if([funktion characterAtIndex:i-1] >= '0' && [funktion characterAtIndex:i-1] <= '9'){

    for (int c=i-1; (c >= 0 && (([funktion characterAtIndex:c] >= '0' && [funktion characterAtIndex:c] <= '9') | ([funktion characterAtIndex:c]=='.'))); c--)
    {
        untenzahl = [NSString stringWithFormat:@"%c%@",[funktion characterAtIndex:c], untenzahl];
        y=c;
    }
        unten=[untenzahl doubleValue];
    }
    else{
        for (int c=i-2; (c >=0) & (klammern>0); c--)
        {
            
            if([funktion characterAtIndex:c]=='('){
                klammern--;
            }
            if([funktion characterAtIndex:c]==')'){
                klammern++;
            }
            
            untenzahl = [NSString stringWithFormat:@"%c%@",[funktion characterAtIndex:c], untenzahl];
            y=c;
        }
        untenzahl=[untenzahl substringFromIndex:1];
        Parser *bla=[[Parser alloc] init];
        unten=[bla xReplace:untenzahl xwert:(@"1")];
    }
        
        
    //potenz berechnen
    ergebniss=pow(unten, oben);
    funktion=[NSString stringWithFormat:@"%@(%f)%@",[funktion substringToIndex:y],ergebniss,[funktion substringFromIndex:x+1]];
        t=0;
        i=0;
        while (i < funktion.length-1 )
        {
            if([funktion characterAtIndex:i]=='^'){
                t++;
            }
            i++;
        }
        t++;
    }
}

//berechnung der tangenz und ersetzen
-(void) tangenz
{
    int i=0;
    int x=0;
    int y=0;
    int anzahl=0;   //anzahl der tan
    int klammern=0; //klammern anzahl
    
    NSString *term=@"";
    double ergebniss=0;
    double wert=0;
    
    //anzahl bestimmen
    while (i < funktion.length-1 )
    {
        if(([funktion characterAtIndex:i]=='t') && ([funktion characterAtIndex:i+1]=='a')){
            anzahl++;
        }
        i++;
    }
    //sooft tangenz vorhanden
    for(int t=anzahl;t>0;t--){
        i=0;
        x=0;
        y=0;
        klammern=1;
        ergebniss=0;
        term=@"";
        
        //suchen nach positon von tan()
        while ((i < funktion.length-1 ) && !(([funktion characterAtIndex:i]=='t')& ([funktion characterAtIndex:i+1]=='a')))
        {
            i++;
            y=i;
         }
        
        //Teilfunktion extrahieren
        for (int c=i+4; ((c < funktion.length) & (klammern>0)); c++)
        {
            if([funktion characterAtIndex:c]=='('){
                klammern++;
            }
            if([funktion characterAtIndex:c]==')'){
                klammern--;
            }
            
            term = [NSString stringWithFormat:@"%@%c", term,[funktion characterAtIndex:c]];
            x=c;
        }
        term=[term substringToIndex:term.length-1];
       
        //teilfunktion berechnen
        Parser *bla=[[Parser alloc] init];
        wert=[bla xReplace:term xwert:(@"1")];
        ergebniss=tan(wert);
        //teil der funktion ersetzen
        funktion=[NSString stringWithFormat:@"%@(%f)%@",[funktion substringToIndex:y],ergebniss,[funktion substringFromIndex:x+1]];
        t=0;
        i=0;
        while (i < funktion.length-1 )
        {
            if(([funktion characterAtIndex:i]=='t') && ([funktion characterAtIndex:i+1]=='a')){
                t++;
            }
            i++;
        }
        t++;
    }
}
-(void) sinus
{
    int i=0;
    int x=0;
    int y=0;
    int anzahl=0; //sinusanzhal
    int klammern=1;//anzahl der klammern
    
    NSString *term=@"";
    double ergebniss=0;
    double wert=0;
    
    //anzahl bestimmen
    while (i < funktion.length-1 )
    {
        if(([funktion characterAtIndex:i]=='s') && ([funktion characterAtIndex:i+1]=='i')){
            anzahl++;
        }
        i++;
    }
    
    //so oft wie sin() vorhanden
    for(int t=anzahl;t>0;t--){
        i=0;
        x=0;
        y=0;
        klammern=1;
        ergebniss=0;
        term=@"";
        
        //position suchen
        while ((i < funktion.length-1 ) && !(([funktion characterAtIndex:i]=='s')& ([funktion characterAtIndex:i+1]=='i')))
        {
            i++;
            y=i;
        }
        
        for (int c=i+4; (c < funktion.length) & (klammern>0); c++)
        {
            if([funktion characterAtIndex:c]=='('){
                klammern++;
            }
            if([funktion characterAtIndex:c]==')'){
                klammern--;
            }
            
            term = [NSString stringWithFormat:@"%@%c", term,[funktion characterAtIndex:c]];
            x=c;
        }
        term=[term substringToIndex:term.length-1];
        Parser *bla=[[Parser alloc] init];
        wert=[bla xReplace:term xwert:(@"1")];
        ergebniss=sin(wert);
        funktion=[NSString stringWithFormat:@"%@(%f)%@",[funktion substringToIndex:y],ergebniss,[funktion substringFromIndex:x+1]];
        
        t=0;
        i=0;
        while (i < funktion.length-1 )
        {
            if(([funktion characterAtIndex:i]=='s') && ([funktion characterAtIndex:i+1]=='i')){
                t++;
            }
            i++;
        }
        t++;
    }
}
-(void) cosinus
{
    int i=0;
    int x=0;
    int y=0;
    int anzahl=0;
    int klammern=1;
    
    NSString *term=@"";
    double ergebniss=0;
    double wert=0;
    
    while (i < funktion.length )
    {
        if([funktion characterAtIndex:i]=='c'){
            anzahl++;
        }
        i++;
    }
    for(int t=anzahl;t>0;t--){
        i=0;
        x=0;
        y=0;
        klammern=1;
        ergebniss=0;
        term=@"";
        
        while ((i < funktion.length ) && ([funktion characterAtIndex:i]!='c'))
        {
            i++;
            y=i;
        }
        
        for (int c=i+4; (c < funktion.length) & (klammern>0); c++)
        {
            if([funktion characterAtIndex:c]=='('){
                klammern++;
            }
            if([funktion characterAtIndex:c]==')'){
                klammern--;
            }
            
            term = [NSString stringWithFormat:@"%@%c", term,[funktion characterAtIndex:c]];
            x=c;
        }
        
        term=[term substringToIndex:term.length-1];
        Parser *bla=[[Parser alloc] init];
        wert=[bla xReplace:term xwert:(@"1")];
        ergebniss=cos(wert);
        funktion=[NSString stringWithFormat:@"%@(%f)%@",[funktion substringToIndex:y],ergebniss,[funktion substringFromIndex:x+1]];
        t=0;
        i=0;
        while (i < funktion.length-1 )
        {
            if([funktion characterAtIndex:i]=='c'){
                t++;
            }
            i++;
        }
        t++;
    }
}

-(void) prozent
{
    int i=0;
    int x=0;
    int y=0;
    int anzahl=0;
    int klammern=1;
    NSString *term=@"";
    double zahl=0;
    
    while (i < funktion.length )
    {
        if([funktion characterAtIndex:i]=='%'){
            anzahl++;
        }
        i++;
    }
    for(int t=anzahl;t>0;t--){
        i=0;
        x=0;
        y=0;
        zahl=0;
        term=@"";

        while ((i < funktion.length ) && ([funktion characterAtIndex:i]!='%'))
        {
            i++;
            x=i;
        }
        
        if([funktion characterAtIndex:i-1] >= '0' && [funktion characterAtIndex:i-1] <= '9'){
            
            for (int c=i-1; (c >= 0 && (([funktion characterAtIndex:c] >= '0' && [funktion characterAtIndex:c] <= '9') | ([funktion characterAtIndex:c]=='.'))); c--)
            {
                term = [NSString stringWithFormat:@"%c%@",[funktion characterAtIndex:c], term];
                y=c;
            }
            zahl=[term doubleValue];
        }
        else{
            for (int c=i-2; (c >=0) & (klammern>0); c--)
            {
                
                if([funktion characterAtIndex:c]=='('){
                    klammern--;
                }
                if([funktion characterAtIndex:c]==')'){
                    klammern++;
                }
                
                term = [NSString stringWithFormat:@"%c%@",[funktion characterAtIndex:c], term];
                y=c;
            }
            term=[term substringFromIndex:1];
            Parser *bla=[[Parser alloc] init];
            zahl=[bla xReplace:term xwert:(@"1")];
        }
        
        zahl=zahl/100;
        
        funktion=[NSString stringWithFormat:@"%@(%f)%@",[funktion substringToIndex:y],zahl,[funktion substringFromIndex:x]];
    }
}

//log
-(void) loga
{
    int i=0;
    int x=0;
    int y=0;
    int anzahl=0;
    int klammern=0;
    
    NSString *term=@"";
    double ergebniss=0;
    double wert=0;
    
    while (i < funktion.length-1 )
    {
        if(([funktion characterAtIndex:i]=='l')&&([funktion characterAtIndex:i+1]=='o')){
            anzahl++;
        }
        i++;
    }
    for(int t=anzahl;t>0;t--){
        i=0;
        x=0;
        y=0;
        klammern=1;
        ergebniss=0;
        term=@"";
        
        while ((i < funktion.length-1 ) && !(([funktion characterAtIndex:i]=='l') & ([funktion characterAtIndex:i+1]=='o')))
        {
            i++;
            y=i;
        }
        
        for (int c=i+4; ((c < funktion.length) & (klammern>0)); c++)
        {
            if([funktion characterAtIndex:c]=='('){
                klammern++;
            }
            if([funktion characterAtIndex:c]==')'){
                klammern--;
            }
            
            term = [NSString stringWithFormat:@"%@%c", term,[funktion characterAtIndex:c]];
            x=c;
        }
        term=[term substringToIndex:term.length-1];
        
        Parser *bla=[[Parser alloc] init];
        wert=[bla xReplace:term xwert:(@"1")];
        ergebniss=log10(wert);
        funktion=[NSString stringWithFormat:@"%@(%f)%@",[funktion substringToIndex:y],ergebniss,[funktion substringFromIndex:x+1]];
        
        t=0;
        i=0;
        while (i < funktion.length-1 )
        {
            if(([funktion characterAtIndex:i]=='l') && ([funktion characterAtIndex:i+1]=='o')){
                t++;
            }
            i++;
        }
        t++;
    }
}

//ln()
-(void) loga10
{
    int i=0;
    int x=0;
    int y=0;
    int anzahl=0;
    int klammern=0;
    
    NSString *term=@"";
    double ergebniss=0;
    double wert=0;
    while (i < funktion.length-1)
    {
        if(([funktion characterAtIndex:i]=='l') && ([funktion characterAtIndex:i+1]=='n')){
            anzahl++;
        }
        i++;
    }
    for(int t=anzahl;t>0;t--){
        i=0;
        x=0;
        y=0;
        klammern=1;
        ergebniss=0;
        term=@"";
        
        while ((i < funktion.length-1 ) && !(([funktion characterAtIndex:i]=='l')&& ([funktion characterAtIndex:i+1]=='n')))
        {
            i++;
            y=i;
        }
        for (int c=i+3; ((c < funktion.length) & (klammern>0)); c++)
        {
            if([funktion characterAtIndex:c]=='('){
                klammern++;
            }
            if([funktion characterAtIndex:c]==')'){
                klammern--;
            }
            
            term = [NSString stringWithFormat:@"%@%c", term,[funktion characterAtIndex:c]];
            x=c;
        }
        term=[term substringToIndex:term.length-1];
        
        Parser *bla=[[Parser alloc] init];
        wert=[bla xReplace:term xwert:(@"1")];
        ergebniss=log(wert);
        funktion=[NSString stringWithFormat:@"%@(%f)%@",[funktion substringToIndex:y],ergebniss,[funktion substringFromIndex:x+1]];
        
        t=0;
        i=0;
        while (i < funktion.length-1 )
        {
            if(([funktion characterAtIndex:i]=='l') && ([funktion characterAtIndex:i+1]=='n')){
                t++;
            }
            i++;
        }
        t++;
    }
}
-(void) wurzel
{
    int i=0;
    int x=0;
    int y=0;
    int anzahl=0;
    int klammern=0;
    
    NSString *term=@"";
    double ergebniss=0;
    double wert=0;
    while (i < funktion.length-1)
    {
        if(([funktion characterAtIndex:i]=='s') && ([funktion characterAtIndex:i+1]=='q')){
            anzahl++;
        }
        i++;
    }
    for(int t=anzahl;t>0;t--){
        i=0;
        x=0;
        y=0;
        klammern=1;
        ergebniss=0;
        term=@"";
        
        while ((i < funktion.length-1 ) && !(([funktion characterAtIndex:i]=='s')& ([funktion characterAtIndex:i+1]=='q')))
        {
            i++;
            y=i;
        }
        for (int c=i+5; ((c < funktion.length) & (klammern>0)); c++)
        {
            if([funktion characterAtIndex:c]=='('){
                klammern++;
            }
            if([funktion characterAtIndex:c]==')'){
                klammern--;
            }
            
            term = [NSString stringWithFormat:@"%@%c", term,[funktion characterAtIndex:c]];
            x=c;
        }
        term=[term substringToIndex:term.length-1];
        
        Parser *bla=[[Parser alloc] init];
        wert=[bla xReplace:term xwert:(@"1")];
        ergebniss=sqrt(wert);
        funktion=[NSString stringWithFormat:@"%@(%f)%@",[funktion substringToIndex:y],ergebniss,[funktion substringFromIndex:x+1]];
        t=0;
        i=0;
        while (i < funktion.length-1 )
        {
            if(([funktion characterAtIndex:i]=='s') && ([funktion characterAtIndex:i+1]=='q')){
                t++;
            }
            i++;
        }
        t++;
    }
}

-(bool) kontrolle:(NSString *)fnkt
{
    fnkt=[fnkt stringByReplacingOccurrencesOfString:@" " withString:@""];
    fnkt=[NSString stringWithFormat:@"(%@)",fnkt];
    int klammern=0;
    
    if (([fnkt characterAtIndex:1] == '^')) {
        return FALSE;
    }
    for(int i=1;i< fnkt.length-1;i++){
        if([fnkt characterAtIndex:i]=='('){
            klammern++;
        }
        if([fnkt characterAtIndex:i]==')'){
            klammern--;
        }
        if(!([fnkt characterAtIndex:i] >= '0' && [fnkt characterAtIndex:i] <= '9')&&([fnkt characterAtIndex:i] != 'c')&&([fnkt characterAtIndex:i] != 'o')&&([fnkt characterAtIndex:i] != 's')&&([fnkt characterAtIndex:i] != 'i')&&([fnkt characterAtIndex:i] != 'n')&&([fnkt characterAtIndex:i] != 'q')&&([fnkt characterAtIndex:i] != 'r')&&([fnkt characterAtIndex:i] != 't')&&([fnkt characterAtIndex:i] != 'a')&&([fnkt characterAtIndex:i] != 'n')&&([fnkt characterAtIndex:i] != 'e')&&([fnkt characterAtIndex:i] != 'g')&&([fnkt characterAtIndex:i] != 'l')&&([fnkt characterAtIndex:i] != 'x')&&([fnkt characterAtIndex:i] != '+')&&([fnkt characterAtIndex:i] != '-')&&([fnkt characterAtIndex:i] != '*')&&([fnkt characterAtIndex:i] != '/')&&([fnkt characterAtIndex:i] != '%')&&([fnkt characterAtIndex:i] != '.')&&([fnkt characterAtIndex:i] != '^')&&([fnkt characterAtIndex:i] != '(')&&([fnkt characterAtIndex:i] != ')')){
            return FALSE;
        }
        switch ([fnkt characterAtIndex:i])
        {
            case '0':
            case '1':
            case '2':
            case '3':
            case '4':
            case '5':
            case '6':
            case '7':
            case '8':
            case '9':
                if (!([fnkt characterAtIndex:i+1] >= '0' && [fnkt characterAtIndex:i+1] <= '9')&&([fnkt characterAtIndex:i+1] != '.')&&([fnkt characterAtIndex:i+1] != '+')&&([fnkt characterAtIndex:i+1] != '-')&&([fnkt characterAtIndex:i+1] != '*')&&([fnkt characterAtIndex:i+1] != '/')&&([fnkt characterAtIndex:i+1] != '%')&&([fnkt characterAtIndex:i+1] != '^')&&([fnkt characterAtIndex:i+1] != '^')&&([fnkt characterAtIndex:i+1] != ')')) {
                    return FALSE;
                }
                break;
            case 'c':
                if ([fnkt characterAtIndex:i+1] != 'o') {
                    return FALSE;
                }
                break;
            case 'o':
                if ([fnkt characterAtIndex:i+1] != 's'&&([fnkt characterAtIndex:i+1] != 'g')) {
                    return FALSE;
                }
                break;
            case 'l':
                if (([fnkt characterAtIndex:i+1] != 'o')&&([fnkt characterAtIndex:i+1] != 'n')) {
                    return FALSE;
                }
                break;
            case 's':
                if (([fnkt characterAtIndex:i+1] != 'q')&&([fnkt characterAtIndex:i+1] != 'i')&&([fnkt characterAtIndex:i+1] != '(')) {
                    return FALSE;
                }
                break;
            case 'i':
                if (([fnkt characterAtIndex:i+1] != 'n')) {
                    return FALSE;
                }
                break;
            case 'n':
                if ([fnkt characterAtIndex:i+1] != '(') {
                    return FALSE;
                }
                break;
            case 'q':
                if ([fnkt characterAtIndex:i+1] != 'r') {
                    return FALSE;
                }
                break;
            case 'r':
                if ([fnkt characterAtIndex:i+1] != 't') {
                    return FALSE;
                }
                break;
            case 't':
                if (([fnkt characterAtIndex:i+1] != 'a')&&([fnkt characterAtIndex:i+1] != '(')) {
                    return FALSE;
                }
                break;
            case 'a':
                if ([fnkt characterAtIndex:i+1] != 'n') {
                    return FALSE;
                }
                break;
            case 'e':
            case 'x':
                if (([fnkt characterAtIndex:i+1] != '+')&&([fnkt characterAtIndex:i+1] != '-')&&([fnkt characterAtIndex:i+1] != '*')&&([fnkt characterAtIndex:i+1] != '/')&&([fnkt characterAtIndex:i+1] != '^')&&([fnkt characterAtIndex:i+1] != ')')) {
                    return FALSE;
                }
                break;
            case '+':
            case '-':
            case '*':
            case '/':
            case'(':
                if (!([fnkt characterAtIndex:i+1] >= '0' && [fnkt characterAtIndex:i+1] <= '9')&&([fnkt characterAtIndex:i+1] != 'c')&&([fnkt characterAtIndex:i+1] != 't')&&([fnkt characterAtIndex:i+1] != 's')&&([fnkt characterAtIndex:i+1] != 'e')&&([fnkt characterAtIndex:i+1] != 'x')&&([fnkt characterAtIndex:i+1] != '(')&&([fnkt characterAtIndex:i+1] != '+')&&([fnkt characterAtIndex:i+1] != '-')) {
                    return FALSE;
                }
                break;
            case '%':
                if (([fnkt characterAtIndex:i+1] != '+')&&([fnkt characterAtIndex:i+1] != '-')&&([fnkt characterAtIndex:i+1] != '*')&&([fnkt characterAtIndex:i+1] != '/')&&([fnkt characterAtIndex:i+1] != ')')) {
                    return FALSE;
                }
                break;
            case '.':
                if (!([fnkt characterAtIndex:i+1] >= '0' && [fnkt characterAtIndex:i+1] <= '9')) {
                    return FALSE;
                }
                break;
            case '^':
                if (!([fnkt characterAtIndex:i+1] >= '0' && [fnkt characterAtIndex:i+1] <= '9')&&([fnkt characterAtIndex:i+1] != '(')&&([fnkt characterAtIndex:i+1] != 'x')&&([fnkt characterAtIndex:i+1] != 'e')) {
                    return FALSE;
                }
                break;
            case ')':
                if (([fnkt characterAtIndex:i+1] != '+')&&([fnkt characterAtIndex:i+1] != '-')&&([fnkt characterAtIndex:i+1] != '*')&&([fnkt characterAtIndex:i+1] != '/')&&([fnkt characterAtIndex:i+1] != '^')&&([fnkt characterAtIndex:i+1] != ')')&&([fnkt characterAtIndex:i+1] != '%')) {
                    return FALSE;
                }
                break;
            default:
                NSLog (@"Fehlt noch was");
                break;
        }
        
    }
    
    if (klammern!=0) {
        return FALSE;
    }

    return TRUE;
}


//startfunktion
- (double) xReplace:(NSString *)expr xwert:(NSString*)zahl
        {
            funktion=[expr stringByReplacingOccurrencesOfString:@" " withString:@""];
            zahl=[NSString stringWithFormat:@"(%@)",zahl];
            funktion=[funktion stringByReplacingOccurrencesOfString:@"x" withString:zahl];
            funktion=[funktion stringByReplacingOccurrencesOfString:@"e" withString:@"2.71828182846"];
            [self potenz];
            [self cosinus];
            [self tangenz];
            [self sinus];
            [self prozent];
            [self loga];
            [self loga10];
            [self wurzel];
            double rueck=[self ParseExpr];
            return rueck;
        }
@end
