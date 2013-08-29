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
    NSLog(@"Funktion:%@",funktion);
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
    NSLog(@"Funktion:%@",funktion);
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
    NSLog(@"Funktion:%@",funktion);
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


//berechnen der potenz und erstetzen
-(void) power
{
    int i=0;
    int x=0;
    int y=0;
    int count=0;   //anzahl der potenzen
    int braces=1; //anzahl der klammern
    
    NSString *upNumber=@""; //zahl die oben steht
    NSString *downNumber=@""; //zahl die unten steht
    double result=0;
    double up=0;  //wert fuer oben
    double down=0; //wert fuer unten
    
    
    //suche nach den Potenzen
    while (i < funktion.length )
    {
        if([funktion characterAtIndex:i]=='^'){
            count++;
        }
        i++;
    }
    //so oft potenzen vorkommen
    for(int t=count;t>0;t--){
        i=0;
        x=0;
        y=0;
        result=0;
        up=0;
        down=0;
        upNumber=@"";
        downNumber=@"";
        
        //nach stelle der potenz suchen
        while ((i < funktion.length ) && ([funktion characterAtIndex:i]!='^'))
        {
            i++;
        }
        
        //trennung ob einzelne zahl oder teilfunktion
        if([funktion characterAtIndex:i+1] >= '0' && [funktion characterAtIndex:i+1] <= '9'){
            
            for (int c=i+1; (c < funktion.length && (([funktion characterAtIndex:c] >= '0' && [funktion characterAtIndex:c] <= '9')| ([funktion characterAtIndex:c]=='.'))); c++)
            {
                upNumber = [NSString stringWithFormat:@"%@%c", upNumber,[funktion characterAtIndex:c]];
                x=c;
            }
            up= [upNumber doubleValue];
        }
        //teilfunktion
        else{
            for (int c=i+2; (c < funktion.length) & (braces>0); c++)
            {
                
                if([funktion characterAtIndex:c]=='('){
                    braces++;
                }
                if([funktion characterAtIndex:c]==')'){
                    braces--;
                }
                //teilfunktion
                upNumber = [NSString stringWithFormat:@"%@%c", upNumber,[funktion characterAtIndex:c]];
                x=c;
            }
            upNumber=[upNumber substringToIndex:upNumber.length-1];
            Parser *bla=[[Parser alloc] init];
            //mithilfe des parser teilfunktion berechnen lassen
            up=[bla xReplace:upNumber xwert:(@"1")];
            
        }
        
        braces=1;
        //unten zahl wie oben zahl
        if([funktion characterAtIndex:i-1] >= '0' && [funktion characterAtIndex:i-1] <= '9'){
            
            for (int c=i-1; (c >= 0 && (([funktion characterAtIndex:c] >= '0' && [funktion characterAtIndex:c] <= '9') | ([funktion characterAtIndex:c]=='.'))); c--)
            {
                downNumber = [NSString stringWithFormat:@"%c%@",[funktion characterAtIndex:c], downNumber];
                y=c;
            }
            down=[downNumber doubleValue];
        }
        else{
            for (int c=i-2; (c >=0) & (braces>0); c--)
            {
                
                if([funktion characterAtIndex:c]=='('){
                    braces--;
                }
                if([funktion characterAtIndex:c]==')'){
                    braces++;
                }
                
                downNumber = [NSString stringWithFormat:@"%c%@",[funktion characterAtIndex:c], downNumber];
                y=c;
            }
            downNumber=[downNumber substringFromIndex:1];
            Parser *bla=[[Parser alloc] init];
            down=[bla xReplace:downNumber xwert:(@"1")];
        }
        
        
        //potenz berechnen
        result=pow(down, up);
        funktion=[NSString stringWithFormat:@"%@(%f)%@",[funktion substringToIndex:y],result,[funktion substringFromIndex:x+1]];
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
-(void) tangent
{
    int i=0;
    int x=0;
    int y=0;
    int count=0;   //anzahl der tan
    int braces=0; //klammern anzahl
    
    NSString *term=@"";
    double result=0;
    double value=0;
    
    //anzahl bestimmen
    while (i < funktion.length-1 )
    {
        if(([funktion characterAtIndex:i]=='t') && ([funktion characterAtIndex:i+1]=='a')){
            count++;
        }
        i++;
    }
    //sooft tangenz vorhanden
    for(int t=count;t>0;t--){
        i=0;
        x=0;
        y=0;
        braces=1;
        result=0;
        term=@"";
        
        //suchen nach positon von tan()
        while ((i < funktion.length-1 ) && !(([funktion characterAtIndex:i]=='t')& ([funktion characterAtIndex:i+1]=='a')))
        {
            i++;
            y=i;
        }
        
        //Teilfunktion extrahieren
        for (int c=i+4; ((c < funktion.length) & (braces>0)); c++)
        {
            if([funktion characterAtIndex:c]=='('){
                braces++;
            }
            if([funktion characterAtIndex:c]==')'){
                braces--;
            }
            
            term = [NSString stringWithFormat:@"%@%c", term,[funktion characterAtIndex:c]];
            x=c;
        }
        term=[term substringToIndex:term.length-1];
        
        //teilfunktion berechnen
        Parser *bla=[[Parser alloc] init];
        value=[bla xReplace:term xwert:(@"1")];
        result=tan(value);
        //teil der funktion ersetzen
        funktion=[NSString stringWithFormat:@"%@(%f)%@",[funktion substringToIndex:y],result,[funktion substringFromIndex:x+1]];
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
    int count=0; //sinusanzhal
    int braces=1;//anzahl der klammern
    
    NSString *term=@"";
    double result=0;
    double value=0;
    
    //anzahl bestimmen
    while (i < funktion.length-1 )
    {
        if(([funktion characterAtIndex:i]=='s') && ([funktion characterAtIndex:i+1]=='i')){
            count++;
        }
        i++;
    }
    
    //so oft wie sin() vorhanden
    for(int t=count;t>0;t--){
        i=0;
        x=0;
        y=0;
        braces=1;
        result=0;
        term=@"";
        
        //position suchen
        while ((i < funktion.length-1 ) && !(([funktion characterAtIndex:i]=='s')& ([funktion characterAtIndex:i+1]=='i')))
        {
            i++;
            y=i;
        }
        
        for (int c=i+4; (c < funktion.length) & (braces>0); c++)
        {
            if([funktion characterAtIndex:c]=='('){
                braces++;
            }
            if([funktion characterAtIndex:c]==')'){
                braces--;
            }
            
            term = [NSString stringWithFormat:@"%@%c", term,[funktion characterAtIndex:c]];
            x=c;
        }
        term=[term substringToIndex:term.length-1];
        Parser *bla=[[Parser alloc] init];
        value=[bla xReplace:term xwert:(@"1")];
        result=sin(value);
        funktion=[NSString stringWithFormat:@"%@(%f)%@",[funktion substringToIndex:y],result,[funktion substringFromIndex:x+1]];
        
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
    int count=0;
    int braces=1;
    
    NSString *term=@"";
    double result=0;
    double value=0;
    
    while (i < funktion.length )
    {
        if([funktion characterAtIndex:i]=='c'){
            count++;
        }
        i++;
    }
    for(int t=count;t>0;t--){
        i=0;
        x=0;
        y=0;
        braces=1;
        result=0;
        term=@"";
        
        while ((i < funktion.length ) && ([funktion characterAtIndex:i]!='c'))
        {
            i++;
            y=i;
        }
        
        for (int c=i+4; (c < funktion.length) & (braces>0); c++)
        {
            if([funktion characterAtIndex:c]=='('){
                braces++;
            }
            if([funktion characterAtIndex:c]==')'){
                braces--;
            }
            
            term = [NSString stringWithFormat:@"%@%c", term,[funktion characterAtIndex:c]];
            x=c;
        }
        
        term=[term substringToIndex:term.length-1];
        Parser *bla=[[Parser alloc] init];
        value=[bla xReplace:term xwert:(@"1")];
        result=cos(value);
        funktion=[NSString stringWithFormat:@"%@(%f)%@",[funktion substringToIndex:y],result,[funktion substringFromIndex:x+1]];
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

-(void) percent
{
    int i=0;
    int x=0;
    int y=0;
    int count=0;
    int braces=1;
    NSString *term=@"";
    double number=0;
    
    while (i < funktion.length )
    {
        if([funktion characterAtIndex:i]=='%'){
            count++;
        }
        i++;
    }
    for(int t=count;t>0;t--){
        i=0;
        x=0;
        y=0;
        number=0;
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
            number=[term doubleValue];
        }
        else{
            for (int c=i-2; (c >=0) & (braces>0); c--)
            {
                
                if([funktion characterAtIndex:c]=='('){
                    braces--;
                }
                if([funktion characterAtIndex:c]==')'){
                    braces++;
                }
                
                term = [NSString stringWithFormat:@"%c%@",[funktion characterAtIndex:c], term];
                y=c;
            }
            term=[term substringFromIndex:1];
            Parser *bla=[[Parser alloc] init];
            number=[bla xReplace:term xwert:(@"1")];
        }
        
        number=number/100;
        
        funktion=[NSString stringWithFormat:@"%@(%f)%@",[funktion substringToIndex:y],number,[funktion substringFromIndex:x]];
    }
}

//log
-(void) loga
{
    int i=0;
    int x=0;
    int y=0;
    int count=0;
    int braces=0;
    
    NSString *term=@"";
    double result=0;
    double value=0;
    
    while (i < funktion.length-1 )
    {
        if(([funktion characterAtIndex:i]=='l')&&([funktion characterAtIndex:i+1]=='o')){
            count++;
        }
        i++;
    }
    for(int t=count;t>0;t--){
        i=0;
        x=0;
        y=0;
        braces=1;
        result=0;
        term=@"";
        
        while ((i < funktion.length-1 ) && !(([funktion characterAtIndex:i]=='l') & ([funktion characterAtIndex:i+1]=='o')))
        {
            i++;
            y=i;
        }
        
        for (int c=i+4; ((c < funktion.length) & (braces>0)); c++)
        {
            if([funktion characterAtIndex:c]=='('){
                braces++;
            }
            if([funktion characterAtIndex:c]==')'){
                braces--;
            }
            
            term = [NSString stringWithFormat:@"%@%c", term,[funktion characterAtIndex:c]];
            x=c;
        }
        term=[term substringToIndex:term.length-1];
        
        Parser *parsObj=[[Parser alloc] init];
        value=[parsObj xReplace:term xwert:(@"1")];
        result=log10(value);
        funktion=[NSString stringWithFormat:@"%@(%f)%@",[funktion substringToIndex:y],result,[funktion substringFromIndex:x+1]];
        
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
    int count=0;
    int braces=0;
    
    NSString *term=@"";
    double result=0;
    double value=0;
    while (i < funktion.length-1)
    {
        if(([funktion characterAtIndex:i]=='l') && ([funktion characterAtIndex:i+1]=='n')){
            count++;
        }
        i++;
    }
    for(int t=count;t>0;t--){
        i=0;
        x=0;
        y=0;
        braces=1;
        result=0;
        term=@"";
        
        while ((i < funktion.length-1 ) && !(([funktion characterAtIndex:i]=='l')&& ([funktion characterAtIndex:i+1]=='n')))
        {
            i++;
            y=i;
        }
        for (int c=i+3; ((c < funktion.length) & (braces>0)); c++)
        {
            if([funktion characterAtIndex:c]=='('){
                braces++;
            }
            if([funktion characterAtIndex:c]==')'){
                braces--;
            }
            
            term = [NSString stringWithFormat:@"%@%c", term,[funktion characterAtIndex:c]];
            x=c;
        }
        term=[term substringToIndex:term.length-1];
        
        Parser *parsObj=[[Parser alloc] init];
        value=[parsObj xReplace:term xwert:(@"1")];
        result=log(value);
        funktion=[NSString stringWithFormat:@"%@(%f)%@",[funktion substringToIndex:y],result,[funktion substringFromIndex:x+1]];
        
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
-(void) root
{
    int i=0;
    int x=0;
    int y=0;
    int count=0;
    int braces=0;
    
    NSString *term=@"";
    double result=0;
    double wert=0;
    while (i < funktion.length-1)
    {
        if(([funktion characterAtIndex:i]=='s') && ([funktion characterAtIndex:i+1]=='q')){
            count++;
        }
        i++;
    }
    for(int t=count;t>0;t--){
        i=0;
        x=0;
        y=0;
        braces=1;
        result=0;
        term=@"";
        
        while ((i < funktion.length-1 ) && !(([funktion characterAtIndex:i]=='s')& ([funktion characterAtIndex:i+1]=='q')))
        {
            i++;
            y=i;
        }
        for (int c=i+5; ((c < funktion.length) & (braces>0)); c++)
        {
            if([funktion characterAtIndex:c]=='('){
                braces++;
            }
            if([funktion characterAtIndex:c]==')'){
                braces--;
            }
            
            term = [NSString stringWithFormat:@"%@%c", term,[funktion characterAtIndex:c]];
            x=c;
        }
        term=[term substringToIndex:term.length-1];
        
        Parser *parsObj=[[Parser alloc] init];
        wert=[parsObj xReplace:term xwert:(@"1")];
        result=sqrt(wert);
        funktion=[NSString stringWithFormat:@"%@(%f)%@",[funktion substringToIndex:y],result,[funktion substringFromIndex:x+1]];
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

-(bool) control:(NSString *)fnkt
{
    fnkt=[fnkt stringByReplacingOccurrencesOfString:@" " withString:@""];
    fnkt=[NSString stringWithFormat:@"(%@)",fnkt];
    int braces=0;
    
    if (([fnkt characterAtIndex:1] == '^')) {
        return FALSE;
    }
    for(int i=1;i< fnkt.length-1;i++){
        if([fnkt characterAtIndex:i]=='('){
            braces++;
        }
        if([fnkt characterAtIndex:i]==')'){
            braces--;
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
    
    if (braces!=0) {
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
    funktion=[funktion stringByReplacingOccurrencesOfString:@"π" withString:@"3.141"];
    [self power];
    [self cosinus];
    [self tangent];
    [self sinus];
    [self percent];
    [self loga];
    [self loga10];
    [self root];
    double rueck=[self ParseExpr];
    return rueck;
}
@end
