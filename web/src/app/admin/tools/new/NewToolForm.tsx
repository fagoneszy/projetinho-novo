"use client";

import Link from "next/link";
import { useState } from "react";
import type { ChangeEvent, FormEvent } from "react";
import { analyzeSecurity, SecurityAnalysisResult } from "@/lib/securityAnalyzer";
import { createTool } from "./actions";

type FormDataState = {
  name: string;
  slug: string;
  description: string;
  category: string;
  problems: number[];
  tags: number[];
  type: string;
  script: string;
  riskLevel: string;
  requiresAdmin: boolean;
  accessesNetwork: boolean;
  modifiesRegistry: boolean;
  writesFiles: boolean;
  deletesFiles: boolean;
  executesExternal: boolean;
  downloadsFiles: boolean;
  createsProcesses: boolean;
  analysisResults: SecurityAnalysisResult | null;
};

const initialFormData: FormDataState = {
    name: "",
    slug: "",
    description: "",
    category: "",
    problems: [], // array of problem IDs
    tags: [], // array of tag IDs
    type: "BAT", // default
    script: "",
    // Security analysis fields (will be filled after analysis)
    riskLevel: "",
    requiresAdmin: false,
    accessesNetwork: false,
    modifiesRegistry: false,
    writesFiles: false,
    deletesFiles: false,
    executesExternal: false,
    downloadsFiles: false,
    createsProcesses: false,
    analysisResults: null as SecurityAnalysisResult | null,
};

export default function NewToolForm() {
  const [formData, setFormData] = useState<FormDataState>(initialFormData);

  const [isAnalyzing, setIsAnalyzing] = useState(false);
  const [analysisError, setAnalysisError] = useState<string | null>(null);
  const [isSubmitting, setIsSubmitting] = useState(false);
  const [submitError, setSubmitError] = useState<string | null>(null);
  const [submitSuccess, setSubmitSuccess] = useState<boolean>(false);

  const handleChange = (e: ChangeEvent<HTMLInputElement | HTMLSelectElement | HTMLTextAreaElement>) => {
    const { name, value, type } = e.target;
    const checked = e.target instanceof HTMLInputElement && e.target.checked;
    setFormData(prev => ({
      ...prev,
      [name]: type === "checkbox" ? checked : value
    }));
  };

  const handleProblemChange = (e: ChangeEvent<HTMLInputElement>) => {
    const problemId = parseInt(e.target.value);
    if (e.target.checked) {
      setFormData(prev => ({
        ...prev,
        problems: [...prev.problems, problemId]
      }));
    } else {
      setFormData(prev => ({
        ...prev,
        problems: prev.problems.filter(id => id !== problemId)
      }));
    }
  };

  const handleTagChange = (e: ChangeEvent<HTMLInputElement>) => {
    const tagId = parseInt(e.target.value);
    if (e.target.checked) {
      setFormData(prev => ({
        ...prev,
        tags: [...prev.tags, tagId]
      }));
    } else {
      setFormData(prev => ({
        ...prev,
        tags: prev.tags.filter(id => id !== tagId)
      }));
    }
  };

  const handleSubmit = async (e: FormEvent<HTMLFormElement>) => {
    e.preventDefault();
    setSubmitError(null);
    setSubmitSuccess(false);
    
    if (!formData.name.trim() || !formData.slug.trim()) {
      setSubmitError("Nome e slug são obrigatórios");
      return;
    }

    setIsSubmitting(true);
    
    try {
      await createTool({
        name: formData.name,
        slug: formData.slug,
        description: formData.description,
        category: formData.category,
        type: formData.type,
        script: formData.script,
      });

      setSubmitSuccess(true);
      setFormData(initialFormData);
    } catch (error) {
      console.error("Submission error:", error);
      setSubmitError("Erro ao salvar a ferramenta. Por favor, tente novamente.");
    } finally {
      setIsSubmitting(false);
    }
  };

  const runSecurityAnalysis = async () => {
    if (!formData.script.trim()) {
      setAnalysisError("Por favor, cole um script para análise");
      return;
    }

    setIsAnalyzing(true);
    setAnalysisError(null);
    
    try {
      // Run the security analysis
      const result = analyzeSecurity(formData.script);
      
      // Update form data with analysis results
      setFormData(prev => ({
        ...prev,
        riskLevel: result.riskLevel,
        // Map analysis results to form fields
        requiresAdmin: result.reasons.some(r => 
          r.includes("Requer Admin") || r.includes("Modifica Registro") || 
          r.includes("Contas de usuário") || r.includes("Serviços")),
        accessesNetwork: result.reasons.some(r => 
          r.includes("Rede") || r.includes("Agenda tarefas") || 
          r.includes("Controle de serviços")),
        modifiesRegistry: result.reasons.some(r => 
          r.includes("Registro") || r.includes("Controle de serviços")),
        writesFiles: result.reasons.some(r => 
          r.includes("Escreve") || r.includes("Cria") || 
          r.includes("Modify")),
        deletesFiles: result.reasons.some(r => 
          r.includes("Deleta") || r.includes("Remove") || 
          r.includes("Limpa") || r.includes("Formata")),
        executesExternal: result.reasons.some(r => 
          r.includes("Executa") || r.includes("WMIC") || 
          r.includes("PowerShell") || r.includes("Rundll32")),
        downloadsFiles: result.reasons.some(r => 
          r.includes("Baixa") || r.includes("Download") || 
          r.includes("Curl") || r.includes("Wget") || 
          r.includes("CertUtil") || r.includes("BitsAdmin")),
        createsProcesses: result.reasons.some(r => 
          r.includes("Cria") || r.includes("Processos") || 
          r.includes("Executa")),
        analysisResults: result
      }));
    } catch (error) {
      setAnalysisError("Erro ao executar análise de segurança");
      console.error("Security analysis error:", error);
    } finally {
      setIsAnalyzing(false);
    }
  };

  // Helper function to get badge classes based on boolean value
  const getBadgeClass = (isTrue: boolean) => {
    return isTrue 
      ? "w-4 h-4 bg-emerald-500/20 text-emerald-400 border border-emerald-500" 
      : "w-4 h-4 bg-zinc-900/50 text-zinc-400";
  };

  // Helper function to get risk level badge class
  const getRiskLevelClass = (level: string) => {
    switch (level) {
      case "LOW": return "h-2.5 w-2.5 rounded-full bg-emerald-500";
      case "MEDIUM": return "h-2.5 w-2.5 rounded-full bg-amber-500";
      case "HIGH": return "h-2.5 w-2.5 rounded-full bg-rose-500";
      default: return "h-2.5 w-2.5 rounded-full bg-zinc-500";
    }
  };

  return (
    <main className="min-h-[100dvh] bg-[#030303] text-zinc-100">
      <div className="mx-auto max-w-4xl px-6 py-12">
        <Link href="/admin" className="text-sm text-zinc-400 mb-4 inline-block">
          ← Voltar ao Painel
        </Link>
        <h1 className="text-2xl font-semibold mb-6">Nova Ferramenta</h1>
        
        {submitSuccess && (
          <div className="mb-4 p-3 bg-emerald-500/20 border border-emerald-500/30 rounded-xl text-emerald-400">
            Ferramenta publicada com sucesso!
          </div>
        )}
        
        {submitError && (
          <div className="mb-4 p-3 bg-rose-500/20 border border-rose-500/30 rounded-xl text-rose-400">
            {submitError}
          </div>
        )}
        
        <form onSubmit={handleSubmit} className="space-y-6">
          <div className="space-y-4">
            <div className="grid grid-cols-2 gap-4">
              <div>
                <label className="block text-sm font-medium text-zinc-400 mb-2">Nome</label>
                <input
                  type="text"
                  name="name"
                  value={formData.name}
                  onChange={handleChange}
                  className="w-full px-4 py-2 rounded-xl border border-zinc-800 bg-zinc-900/50 focus:outline-none focus:ring-2 focus:ring-zinc-600"
                  required
                />
              </div>
              <div>
                <label className="block text-sm font-medium text-zinc-400 mb-2">Slug</label>
                <input
                  type="text"
                  name="slug"
                  value={formData.slug}
                  onChange={handleChange}
                  className="w-full px-4 py-2 rounded-xl border border-zinc-800 bg-zinc-900/50 focus:outline-none focus:ring-2 focus:ring-zinc-600"
                  required
                />
              </div>
            </div>
            
            <div>
              <label className="block text-sm font-medium text-zinc-400 mb-2">Descrição</label>
              <textarea
                name="description"
                value={formData.description}
                onChange={handleChange}
                className="w-full px-4 py-2 rounded-xl border border-zinc-800 bg-zinc-900/50 focus:outline-none focus:ring-2 focus:ring-zinc-600"
                rows={4}
                required
              />
            </div>
            
            <div className="grid grid-cols-2 gap-4">
              <div>
                <label className="block text-sm font-medium text-zinc-400 mb-2">Categoria</label>
                <select
                  name="category"
                  value={formData.category}
                  onChange={handleChange}
                  className="w-full px-4 py-2 rounded-xl border border-zinc-800 bg-zinc-900/50 focus:outline-none focus:ring-2 focus:ring-zinc-600"
                  required
                >
                  <option value="">Selecione uma categoria</option>
                  <option value="rede">Rede</option>
                  <option value="seguranca">Segurança</option>
                  <option value="diagnostics">Diagnóstico</option>
                  <option value="utilitarios">Utilitários</option>
                  <option value="desenvolvimento">Desenvolvimento</option>
                  <option value="automacao">Automação</option>
                  <option value="arquivos">Arquivos</option>
                  <option value="midia">Mídia</option>
                  <option value="sistema">Sistema</option>
                </select>
              </div>
              <div>
                <label className="block text-sm font-medium text-zinc-400 mb-2">Tipo</label>
                <select
                  name="type"
                  value={formData.type}
                  onChange={handleChange}
                  className="w-full px-4 py-2 rounded-xl border border-zinc-800 bg-zinc-900/50 focus:outline-none focus:ring-2 focus:ring-zinc-600"
                  required
                >
                  <option value="BAT">BAT</option>
                  <option value="PS1">PS1</option>
                  <option value="CMD">CMD</option>
                  <option value="PY">Python</option>
                  <option value="SH">Shell</option>
                </select>
              </div>
            </div>
          </div>
          
          <div className="border-t border-zinc-800/50 pt-6">
            <h2 className="text-xl font-semibold mb-4">Problemas Relacionados</h2>
            <div className="space-y-2">
              {/* In a real implementation, we'd fetch problems from db */}
              <label className="flex items-center">
                <input
                  type="checkbox"
                  onChange={handleProblemChange}
                  className="w-4 h-4 text-zinc-600 border-zinc-600 rounded"
                />
                <span className="ml-2">DNS</span>
              </label>
              <label className="flex items-center">
                <input
                  type="checkbox"
                  onChange={handleProblemChange}
                  className="w-4 h-4 text-zinc-600 border-zinc-600 rounded"
                />
                <span className="ml-2">Internet</span>
              </label>
              <label className="flex items-center">
                <input
                  type="checkbox"
                  onChange={handleProblemChange}
                  className="w-4 h-4 text-zinc-600 border-zinc-600 rounded"
                />
                <span className="ml-2">Rede</span>
              </label>
              <label className="flex items-center">
                <input
                  type="checkbox"
                  onChange={handleProblemChange}
                  className="w-4 h-4 text-zinc-600 border-zinc-600 rounded"
                />
                <span className="ml-2">Segurança</span>
              </label>
            </div>
          </div>
          
          <div className="border-t border-zinc-800/50 pt-6">
            <h2 className="text-xl font-semibold mb-4">Tags</h2>
            <div className="space-y-2">
              {/* In a real implementation, we'd fetch tags from db */}
              <label className="flex items-center">
                <input
                  type="checkbox"
                  onChange={handleTagChange}
                  className="w-4 h-4 text-zinc-600 border-zinc-600 rounded"
                />
                <span className="ml-2">dns</span>
              </label>
              <label className="flex items-center">
                <input
                  type="checkbox"
                  onChange={handleTagChange}
                  className="w-4 h-4 text-zinc-600 border-zinc-600 rounded"
                />
                <span className="ml-2">network</span>
              </label>
              <label className="flex items-center">
                <input
                  type="checkbox"
                  onChange={handleTagChange}
                  className="w-4 h-4 text-zinc-600 border-zinc-600 rounded"
                />
                <span className="ml-2">windows</span>
              </label>
            </div>
          </div>
          
          <div className="border-t border-zinc-800/50 pt-6">
            <h2 className="text-xl font-semibold mb-4">Script</h2>
            <div className="relative">
              <textarea
                name="script"
                value={formData.script}
                onChange={handleChange}
                className="w-full px-4 py-2 rounded-xl border border-zinc-800 bg-black/50 text-zinc-100 font-mono"
                rows={8}
                placeholder="Cole o script aqui..."
              />
              <div className="absolute top-2 right-2 flex items-center space-x-2 text-xs text-zinc-400">
                <span className="font-medium">Ctrl+Enter</span> para analisar segurança
              </div>
            </div>
          </div>
          
          <div className="border-t border-zinc-800/50 pt-6">
            <h2 className="text-xl font-semibold mb-4">Análise de Segurança</h2>
            <div className="space-y-4">
              <div className="flex items-center">
                <div className="w-20">
                  <div className={getRiskLevelClass(formData.riskLevel)} />
                </div>
                <div className="ml-3">
                  <p className="font-medium text-white">{formData.riskLevel || "N/A"}</p>
                  <p className="text-sm text-zinc-400">Nível de Risco</p>
                </div>
              </div>
              
              <div className="grid gap-2 sm:grid-cols-3">
                <div className="flex items-center">
                  <span className={getBadgeClass(formData.requiresAdmin)} />
                  <span className="ml-2">Requer Admin</span>
                </div>
                <div className="flex items-center">
                  <span className={getBadgeClass(formData.accessesNetwork)} />
                  <span className="ml-2">Acesso à Rede</span>
                </div>
                <div className="flex items-center">
                  <span className={getBadgeClass(formData.modifiesRegistry)} />
                  <span className="ml-2">Modifica Registro</span>
                </div>
              </div>
              
              <div className="grid gap-2 sm:grid-cols-3">
                <div className="flex items-center">
                  <span className={getBadgeClass(formData.writesFiles)} />
                  <span className="ml-2">Escreve Arquivos</span>
                </div>
                <div className="flex items-center">
                  <span className={getBadgeClass(formData.deletesFiles)} />
                  <span className="ml-2">Deleta Arquivos</span>
                </div>
                <div className="flex items-center">
                  <span className={getBadgeClass(formData.executesExternal)} />
                  <span className="ml-2">Executa Externo</span>
                </div>
              </div>
              
              <div className="grid gap-2 sm:grid-cols-3">
                <div className="flex items-center">
                  <span className={getBadgeClass(formData.downloadsFiles)} />
                  <span className="ml-2">Baixa Arquivos</span>
                </div>
                <div className="flex items-center">
                  <span className={getBadgeClass(formData.createsProcesses)} />
                  <span className="ml-2">Cria Processos</span>
                </div>
              </div>
            </div>
          </div>
          
          <div className="mt-6 flex justify-end space-x-4">
            <button
              type="button"
              onClick={() => {
                runSecurityAnalysis();
              }}
              className="px-6 py-3 rounded-xl bg-zinc-800/50 text-zinc-300 hover:bg-zinc-700/50 transition-colors duration-200"
            >
              Executar Análise
            </button>
            <button
              type="submit"
              disabled={isSubmitting}
              className="px-6 py-3 rounded-xl bg-white text-black font-medium hover:bg-zinc-100 transition-colors duration-200"
            >
              Salvar Rascunho
            </button>
            <button
              type="submit"
              disabled={isSubmitting || !formData.analysisResults}
              className="px-6 py-3 rounded-xl bg-white text-black font-medium hover:bg-zinc-100 transition-colors duration-200"
            >
              Publicar
            </button>
          </div>
          
          {isAnalyzing && (
            <div className="mt-4 text-center text-zinc-400">
              Analisando segurança...
            </div>
          )}
          
          {analysisError && (
            <div className="mt-4 p-3 bg-rose-500/20 border border-rose-500/30 rounded-xl text-rose-400">
              {analysisError}
            </div>
          )}
          
          {formData.analysisResults && (
            <div className="mt-6">
              <div className="flex items-center space-x-4">
                <div className="w-20">
                  <div className={getRiskLevelClass(formData.analysisResults.riskLevel)} />
                </div>
                <div>
                  <p className="font-medium text-white">{formData.analysisResults.riskLevel}</p>
                  <p className="text-sm text-zinc-400">Nível de Risco</p>
                </div>
              </div>
              
              <div className="mt-4 space-y-2">
                <h3 className="text-lg font-semibold mb-2 text-zinc-300">Motivos:</h3>
                <ul className="list-disc list-inside space-y-1 text-zinc-300">
                  {formData.analysisResults.reasons.map((reason, index) => (
                    <li key={index}>{reason}</li>
                  ))}
                </ul>
                
                <h3 className="text-lg font-semibold mb-2 text-zinc-300 mt-4">Não foram detectados:</h3>
                <ul className="list-disc list-inside space-y-1 text-zinc-300">
                  {formData.analysisResults.notDetected.map((item, index) => (
                    <li key={index}>{item}</li>
                  ))}
                </ul>
              </div>
            </div>
          )}
        </form>
      </div>
    </main>
  );
}