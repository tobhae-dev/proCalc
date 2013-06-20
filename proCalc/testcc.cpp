//
//  testcc.cpp
//  proCalc
//
//  Created by Jonas on 6/13/13.
//  Copyright (c) 2013 jonatobi. All rights reserved.
//

#include "testcc.h"

    class Test
    {
        
        
        public double xReplace(String expr:String zahl)
        {
            expr = expr.Replace('x', '3');
            
            return ParseExpr(ref expr);
        }
        public double ParseExpr(String expr)
        {
            double op , op1;
            op = ParseFactor(ref expr);
            if (expr.Length != 0 )
            {
                if (expr[0] == '+')
                {
                    expr = expr.Substring(1, expr.Length - 1);
                    op1 = ParseExpr(ref expr);
                    op += op1;
                }
                else if (expr[0] == '-')
                {
                    expr = expr.Substring(1, expr.Length - 1);
                    op1 = ParseExpr(ref expr);
                    op -= op1;
                }
            }
            return op;
        }
        public double ParseFactor(string expr)
        {
            double op, op1;
            op = ParseTerm(ref expr);
            if (expr.Length != 0)
            {
                if (expr[0] == '*')
                {
                    expr = expr.Substring(1, expr.Length - 1);
                    op1 = ParseFactor(ref expr);
                    op *= op1;
                }
                else if (expr[0] == '/')
                {
                    expr = expr.Substring(1, expr.Length - 1);
                    op1 = ParseFactor(ref expr);
                    op /= op1;
                }
            }
            return op;
        }
        public double ParseTerm(ref string expr)
        {
            double returnValue = 0;
            if (expr.Length != 0)
            {
                if (char.IsDigit(expr[0]))
                {
                    returnValue = ParseNumber(ref expr);
                    return returnValue;
                }
                else if (expr[0] == '(')
                {
                    expr = expr.Substring(1, expr.Length - 1);
                    returnValue = ParseExpr(ref expr);
                    expr = expr.Substring(1, expr.Length - 1); //removing closing parenthesis
                    return returnValue;
                }
            }
            return returnValue;
        }
        
        public double ParseNumber(ref string expr)
        {
            string numberTemp = "";
            int c = 0;
            for (int i=0; i < expr.Length && (char.IsDigit(expr[i]) |expr[i]==','); i++)
            {
                if (char.IsDigit(expr[0]))
                {
                    numberTemp += expr[i];
                    c++;
                }
            }
            expr = expr.Substring(c, expr.Length-c);
            return double.Parse(numberTemp);
        }
    }
}