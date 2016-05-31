//===- WTFJH.cpp ---------------------------------------------===//
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
#include <iostream>
#include <string>
#include <sstream>
#include <vector>

using namespace clang;
using namespace std;
using namespace llvm;



class WTFJHVisitor
  : public RecursiveASTVisitor<WTFJHVisitor> {
public:

  WTFJHVisitor(ASTContext *Context,SourceManager* Manager)
    : Context(Context),Manager(Manager),_rewriter(*Manager,Context->getLangOpts ()){

    }



  void HandleTranslationUnit(ASTContext &context)
    {
      TraverseDecl(context.getTranslationUnitDecl());
    }
  bool VisitObjCPropertyDecl(ObjCPropertyDecl *declaration)
    {
      if(Manager->isInMainFile(declaration->getSourceRange ().getBegin () )){ 

        VisitObjCMethodDecl(declaration->getGetterMethodDecl ());

        VisitObjCMethodDecl(declaration->getSetterMethodDecl ());
      }






      return true;
    }




  bool VisitObjCMethodDecl(ObjCMethodDecl *declaration)
    {
      if(Manager->isInMainFile(declaration->getSourceRange ().getBegin () )){
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
        llvm::errs()<<declaration->getSelector ().getNameForSlot(0);//Add First Part of the Selector
        llvm::ArrayRef<clang::ParmVarDecl*> PVD=declaration->parameters();
        for(llvm::ArrayRef<clang::ParmVarDecl*>::iterator iter=PVD.begin();iter!=PVD.end();++iter)
        {
          const clang::ParmVarDecl* PTI=*iter;
          llvm::errs()<<":("<<PTI->getOriginalType ().getAsString ()<<")"<<PTI->getNameAsString () <<" ";
        }
       // llvm::errs()<<declaration->getReturnType().getAsString ()<<" ";
        llvm::errs()<<"{\n";//Start of Bracket
        if(declaration->getReturnType().getAsString ()!="void"){

          llvm::errs()<<declaration->getReturnType().getAsString ()<<" RetVal=%orig\n";
        }
        else{
          llvm::errs()<<"%orig;\n";
        }

        llvm::errs() <<"if(WTShouldLog){\n";

        //WTShouldLog Called
        llvm::errs()<<"  WTInit(@\""<<declaration->getClassInterface()->getObjCRuntimeNameAsString ()<<",@\""<<declaration->getSelector ().getAsString()<<"\");\n";
        //WTAdd Code
        for(llvm::ArrayRef<clang::ParmVarDecl*>::iterator iter=PVD.begin();iter!=PVD.end();++iter)
        {
          const clang::ParmVarDecl* PTI=*iter;
          llvm::errs()<<"  WTAdd("<<WrapperGenerator(PTI->getOriginalType ().getAsString (),PTI->getNameAsString ())<<",@\""<<PTI->getNameAsString ()<<"\");\n";
        }        

        
        if(declaration->getReturnType().getAsString ()!="void"){

          llvm::errs()<<"  WTReturn("<<WrapperGenerator(declaration->getReturnType().getAsString (),"RetVal")<<");";
        }
        llvm::errs()<<"\n  WTSave;\n  WTRelease;\n}\n";//End of Bracket
        if(declaration->getReturnType().getAsString ()!="void"){

          llvm::errs()<<"\nreturn RetVal;\n";
        }
        llvm::errs()<<"\n}\n%end\n";
        }
            return true;
    }
    static std::string WrapperGenerator(std::string Type,std::string ArgName){
      
      std::ostringstream Wrapper;
        if(Type=="SInt32"){
          Wrapper<<"[NSNumber numberWithInt:"<<ArgName<<"]";
        }
        else{
          Wrapper<<ArgName;
        }

      return Wrapper.str();
    }



  private:
  ASTContext *Context;
  SourceManager* Manager;
  typedef clang::RecursiveASTVisitor<WTFJHVisitor> Base;
  clang::Rewriter _rewriter;

  };
class WTFJHConsumer : public clang::ASTConsumer {
public:
    explicit WTFJHConsumer(ASTContext *Context,SourceManager* Manager): Visitor(Context,Manager) {}
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
  WTFJHVisitor Visitor;
};


class WTFJHAction : public PluginASTAction {
protected:
  std::unique_ptr<ASTConsumer> CreateASTConsumer(CompilerInstance &CI,
                                                 llvm::StringRef) override {
    llvm::errs()<<"WTFJH----Visiting Headers\n";
    return llvm::make_unique<WTFJHConsumer>(&CI.getASTContext(),&CI.getSourceManager ());
  }

  bool ParseArgs(const CompilerInstance &CI,
                 const std::vector<std::string> &args) override {

    return true;
  }
  void PrintHelp(llvm::raw_ostream& ros) {
    ros << "Add -WTFJH to Generate Modules From Specific Header";
  }

};


static FrontendPluginRegistry::Add<WTFJHAction> X("-WTFJH", "Generate Modules From Specific Header");





