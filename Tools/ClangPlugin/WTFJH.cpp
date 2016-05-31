//===- Obfuscator.cpp ---------------------------------------------===//
//
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//
//
// Example clang plugin which simply prints the names of all the top-level decls
// in the input file.
//
//===----------------------------------------------------------------------===//
#include "clang/Frontend/FrontendPluginRegistry.h"
#include "clang/AST/AST.h"
#include "clang/AST/ParentMap.h"
#include "clang/AST/ASTConsumer.h"
#include "clang/AST/RecursiveASTVisitor.h"
#include "clang/Frontend/CompilerInstance.h"
#include "clang/Sema/Sema.h"
#include "llvm/Support/raw_ostream.h"
#include "clang/Rewrite/Core/Rewriter.h"
#include "clang/Frontend/FrontendAction.h"
#include "clang/AST/Type.h"
#include "clang/Lex/Lexer.h"
#include "clang/Lex/Lexer.h"
#include "llvm/Support/RandomNumberGenerator.h"
#include <iostream>
#include <string>
#include <sstream>
#include <vector>
#include <random>
#include <time.h>
//Setup Random Name Array
#define ObfuscateStringList {"A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z","a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z"}
#define ObfuscateListSize 52
std::string arrayString[] = ObfuscateStringList;
//End

//todo:
//clang::ObjCSelectorExpr
//


using namespace clang;
using namespace std;
using namespace llvm;



class ObfuscatorVisitor
  : public RecursiveASTVisitor<ObfuscatorVisitor> {
public:

  ObfuscatorVisitor(ASTContext *Context,SourceManager* Manager)
    : Context(Context),Manager(Manager),_rewriter(*Manager,Context->getLangOpts ()){

    }



  void HandleTranslationUnit(ASTContext &context)
    {
      TraverseDecl(context.getTranslationUnitDecl());
    }
  bool VisitObjCMethodDecl(ObjCMethodDecl *declaration)
    {
      if(Manager->isInMainFile(declaration->getSourceRange ().getBegin () )){
        //Need To Break Down The Selector Into Parts
         /* llvm::errs()<<"ObjcMethod:"<<declaration->getNameAsString ()<<"\n";
          SplitSelector(declaration->getNameAsString ());*/
        llvm::errs()<<"%hook "<<declaration->getClassInterface()->getObjCRuntimeNameAsString ()<<"\n";
        if(declaration->isInstanceMethod ()){
          //Class/Instance Method.Doesn't Really Matter Though.
          llvm::errs()<<"-(";
        }
        else{
          llvm::errs()<<"+(";
        }
        //Now Build Return Type
        llvm::errs()<<declaration->getReturnType().getAsString ()<<")";
        //Build Method
        llvm::errs()<<declaration->getSelector ().getNameForSlot(0)<<":";//Add First Part of the Selector


        llvm::ArrayRef<clang::ParmVarDecl*> PVD=declaration->parameters();
        int ArgCounter=1;
        for(llvm::ArrayRef<clang::ParmVarDecl*>::iterator iter=PVD.begin();iter!=PVD.end();++iter)
        {
          const clang::ParmVarDecl* PTI=*iter;
          llvm::errs()<<"("<<PTI->getOriginalType ().getAsString ()<<")arg"<<ArgCounter<<" ";
          ArgCounter++;
        }
       // llvm::errs()<<declaration->getReturnType().getAsString ()<<" ";
        llvm::errs()<<"{\n"<<declaration->getReturnType().getAsString ()<<" RetVal=%orig\nif(WTShouldLog){";//Start of Bracket

        

        llvm::errs()<<"\n}\n";//End of Bracket

        llvm::errs()<<"\nreturn RetVal;\n}\n%end\n";
        llvm::errs()<<"\n";
        }
            return true;
    }

  private:
  ASTContext *Context;
  SourceManager* Manager;
  typedef clang::RecursiveASTVisitor<ObfuscatorVisitor> Base;
  clang::Rewriter _rewriter;

  };
class ObfuscatorConsumer : public clang::ASTConsumer {
public:
    explicit ObfuscatorConsumer(ASTContext *Context,SourceManager* Manager): Visitor(Context,Manager) {}
    virtual bool HandleTopLevelDecl(DeclGroupRef DG) {
        // a DeclGroupRef may have multiple Decls, so we iterate through each one
        for (DeclGroupRef::iterator i = DG.begin(), e = DG.end(); i != e; i++) {
            Decl *D = *i;
            Visitor.TraverseDecl(D); // recursively visit each AST node in Decl "D"
        }
        return true;
            }
private:
  SourceManager *Manager;
  ObfuscatorVisitor Visitor;
};


class ObfuscatorAction : public PluginASTAction {
protected:
  std::unique_ptr<ASTConsumer> CreateASTConsumer(CompilerInstance &CI,
                                                 llvm::StringRef) override {
    llvm::errs()<<"WTFJH----Visiting Headers\n";
    return llvm::make_unique<ObfuscatorConsumer>(&CI.getASTContext(),&CI.getSourceManager ());
  }

  bool ParseArgs(const CompilerInstance &CI,
                 const std::vector<std::string> &args) override {

    return true;
  }
  void PrintHelp(llvm::raw_ostream& ros) {
    ros << "Add -WTFJH to Generate Modules From Specific Header";
  }

};


static FrontendPluginRegistry::Add<ObfuscatorAction> X("-WTFJH", "Generate Modules From Specific Header");





