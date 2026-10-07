"use client";
import Link from "next/link";
import { useState } from "react";
import type { ChangeEvent } from "react";

type AdminTool = {
  id: number;
  name: string;
  slug: string;
  description: string | null;
  status: string;
  categoryName: string;
  riskLevel: string | null;
  createdAt: string;
};

export default function AdminToolsClient({
  initialTools,
}: {
  initialTools: AdminTool[];
}) {
  // State for filtering and pagination
  const [filters, setFilters] = useState({
    status: "all",
    category: "",
    search: "",
  });

  const categories = [...new Set(initialTools.map((tool) => tool.categoryName))];
  const toolsData = initialTools.filter((tool) => {
    const matchesStatus = filters.status === "all" || tool.status === filters.status;
    const matchesCategory = !filters.category || tool.categoryName === filters.category;
    const search = filters.search.trim().toLowerCase();
    const matchesSearch =
      !search ||
      tool.name.toLowerCase().includes(search) ||
      (tool.description ?? "").toLowerCase().includes(search);
    return matchesStatus && matchesCategory && matchesSearch;
  });

  const handleFilterChange = (e: ChangeEvent<HTMLSelectElement>) => {
    const { name, value } = e.target;
    setFilters(prev => ({ ...prev, [name]: value }));
  };

  const handleSearchChange = (e: ChangeEvent<HTMLInputElement>) => {
    setFilters(prev => ({ ...prev, search: e.target.value }));
  };

  const handleResetFilters = () => {
    setFilters({ status: "all", category: "", search: "" });
  };

  return (
    <main className="min-h-[100dvh] bg-[#030303] text-zinc-100">
      <div className="mx-auto max-w-7xl px-6 py-12">
        <div className="flex justify-between items-center mb-8">
          <h1 className="text-2xl font-semibold">Gerenciamento de Ferramentas</h1>
          <div className="flex space-x-3">
            <Link 
              href="/admin/tools/new" 
              className="batlab-button px-5 py-2.5 rounded-full bg-white text-black font-medium hover:bg-zinc-100 transition-colors duration-200"
            >
              + Nova Ferramenta
            </Link>
            <button
              onClick={handleResetFilters}
              className="batlab-button px-5 py-2.5 rounded-full bg-zinc-800/50 text-zinc-300 hover:bg-zinc-700/50 transition-colors duration-200"
            >
              Reset Filtros
            </button>
          </div>
        </div>
        
        <div className="mb-6">
          <div className="grid grid-cols-2 md:grid-cols-4 gap-3 mb-4">
            <div>
              <label className="block text-sm font-medium text-zinc-400 mb-1">Status</label>
              <select
                name="status"
                value={filters.status}
                onChange={handleFilterChange}
                className="w-full px-3 py-1 rounded border border-zinc-800 bg-zinc-900/50 text-zinc-300 focus:outline-none focus:ring-2 focus:ring-zinc-600"
              >
                <option value="all">Todos</option>
                <option value="published">Publicadas</option>
                <option value="draft">Rascunhos</option>
                <option value="review">Em Revisão</option>
                <option value="analyzing">Analisando</option>
              </select>
            </div>
            <div>
              <label className="block text-sm font-medium text-zinc-400 mb-1">Categoria</label>
              <select
                name="category"
                value={filters.category}
                onChange={handleFilterChange}
                className="w-full px-3 py-1 rounded border border-zinc-800 bg-zinc-900/50 text-zinc-300 focus:outline-none focus:ring-2 focus:ring-zinc-600"
              >
                <option value="">Todas as Categorias</option>
                {categories.map((category) => (
                  <option key={category} value={category}>
                    {category}
                  </option>
                ))}
              </select>
            </div>
            <div className="col-span-2">
              <label className="block text-sm font-medium text-zinc-400 mb-1">Buscar</label>
              <div className="relative">
                <input
                  type="text"
                  placeholder="Buscar por nome ou descrição..."
                  value={filters.search}
                  onChange={handleSearchChange}
                  className="w-full px-3 py-1 rounded border border-zinc-800 bg-zinc-900/50 text-zinc-300 focus:outline-none focus:ring-2 focus:ring-zinc-600"
                />
              </div>
            </div>
          </div>
        </div>
        
          <div className="overflow-x-auto">
            <table className="w-full border-collapse">
              <thead>
                <tr className="border-b border-zinc-800">
                  <th className="text-left text-xs font-medium text-zinc-400 py-3">Nome</th>
                  <th className="text-left text-xs font-medium text-zinc-400 py-3">Categoria</th>
                  <th className="text-left text-xs font-medium text-zinc-400 py-3">Status</th>
                  <th className="text-left text-xs font-medium text-zinc-400 py-3">Risco</th>
                  <th className="text-left text-xs font-medium text-zinc-400 py-3">Data</th>
                  <th className="text-left text-xs font-medium text-zinc-400 py-3">Ações</th>
                </tr>
              </thead>
              <tbody>
                {toolsData.length > 0 ? (
                  toolsData.map((tool) => (
                    <tr key={tool.id} className="border-t border-zinc-800/50 hover:bg-zinc-900/20">
                      <td className="py-4">
                        <div className="flex items-center space-x-3">
                          <div className="w-8 h-8 bg-zinc-800/50 rounded-lg flex items-center justify-center text-zinc-400">
                            {/* Status icon */}
                            {tool.status === "published" ? "✓" : tool.status === "draft" ? "◌" : tool.status === "review" ? "⟳" : "⚙️"}
                          </div>
                          <div>
                            <p className="font-medium text-white">{tool.name}</p>
                            <p className="text-sm text-zinc-400">{tool.slug}</p>
                          </div>
                        </div>
                      </td>
                      <td className="py-4">
                        <span className="px-2 py-0.5 rounded text-xs bg-zinc-800/50 text-zinc-300">
                          {tool.categoryName || "Sem categoria"}
                        </span>
                      </td>
                      <td className="py-4">
                        <span className={`px-2 py-0.5 rounded text-xs ${tool.status === "published" ? "bg-emerald-500/20 text-emerald-400" : tool.status === "draft" ? "bg-amber-500/20 text-amber-400" : tool.status === "review" ? "bg-rose-500/20 text-rose-400" : "bg-zinc-800/20 text-zinc-300"}`}>
                          {tool.status === "published" ? "Publicada" : tool.status === "draft" ? "Rascunho" : tool.status === "review" ? "Em Revisão" : "Analisando"}
                        </span>
                      </td>
                      <td className="py-4">
                        <span className="text-sm text-zinc-400">
                          {tool.riskLevel ?? "N/A"}
                        </span>
                      </td>
                      <td className="py-4">
                        <span className="text-sm text-zinc-400">
                          {new Date(tool.createdAt).toLocaleDateString("pt-BR")}
                        </span>
                      </td>
                      <td className="py-4">
                        <div className="flex items-center space-x-2">
                          <Link 
                            href={`/admin/tools/${tool.id}/edit`} 
                            className="text-xs text-zinc-400 hover:text-zinc-300"
                          >
                            Editar
                          </Link>
                          <Link 
                            href={`/admin/tools/${tool.id}`} 
                            className="text-xs text-zinc-400 hover:text-zinc-300"
                          >
                            Ver
                          </Link>
                        </div>
                      </td>
                    </tr>
                  ))
                ) : (
                  <tr>
                    <td colSpan={6} className="py-8 text-center text-zinc-500">
                      Nenhuma ferramenta encontrada com os filtros aplicados
                    </td>
                  </tr>
                )}
              </tbody>
            </table>
          </div>
        
        {/* Pagination would go here if needed */}
      </div>
    </main>
  );
}
