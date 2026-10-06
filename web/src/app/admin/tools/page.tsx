"use client";

import Link from "next/link";
import { getSession } from "@/lib/session";
import { redirect } from "next/navigation";
import { useState, useEffect } from "react";
import { db } from "@/lib/db";
import { tools, toolSecurity, adminUsers, categories } from "@/drizzle/schema";
import { eq, and, ilike } from "drizzle-orm";

export default async function AdminTools() {
  const session = await getSession();
  if (!session) redirect("/login");

  // Check if user is admin
  const [adminRecord] = await db
    .select()
    .from(adminUsers)
    .where(eq(adminUsers.userId, session.user.id))
    .limit(1);

  if (!adminRecord) redirect("/");

  // State for filtering and pagination
  const [filters, setFilters] = useState({
    status: "all",
    category: "",
    search: "",
  });
  
  const [toolsData, setToolsData] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);
  const [categoriesData, setCategoriesData] = useState([]);

  // Fetch tools with filters
  const fetchTools = async () => {
    setLoading(true);
    setError(null);
    
    try {
      let query = db
        .select({
          id: tools.id,
          name: tools.name,
          slug: tools.slug,
          description: tools.description,
          status: tools.status,
          categoryName: categories.name,
          riskLevel: toolSecurity.riskLevel,
          createdAt: tools.createdAt,
        })
        .from(tools)
        .leftJoin(toolSecurity, eq(tools.id, toolSecurity.toolId))
        .leftJoin(categories, eq(tools.categoryId, categories.id));
      
      // Apply filters
      if (filters.status !== "all") {
        query = query.where(eq(tools.status, filters.status));
      }
      
      if (filters.category) {
        query = query.where(eq(tools.categoryId, parseInt(filters.category)));
      }
      
      if (filters.search) {
        query = query.where(
          and(
            ilike(tools.name, `%${filters.search}%`),
            ilike(tools.description, `%${filters.search}%`)
          )
        );
      }
      
      const data = await query.orderBy(tools.createdAt.desc());
      setToolsData(data);
    } catch (err) {
      console.error("Error fetching tools:", err);
      setError("Erro ao carregar ferramentas");
    } finally {
      setLoading(false);
    }
  };

  // Fetch categories for filter dropdown
  const fetchCategories = async () => {
    try {
      const data = await db.select().from(categories).orderBy(categories.name);
      setCategoriesData(data);
    } catch (err) {
      console.error("Error fetching categories:", err);
    }
  };

  useEffect(() => {
    fetchCategories();
    fetchTools();
  }, [filters.status, filters.category, filters.search]);

  const handleFilterChange = (e) => {
    const { name, value } = e.target;
    setFilters(prev => ({ ...prev, [name]: value }));
  };

  const handleSearchChange = (e) => {
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
              className="px-4 py-2 rounded-xl bg-white text-black font-medium hover:bg-zinc-100 transition-colors duration-200"
            >
              + Nova Ferramenta
            </Link>
            <button
              onClick={handleResetFilters}
              className="px-4 py-2 rounded-xl bg-zinc-800/50 text-zinc-300 hover:bg-zinc-700/50 transition-colors duration-200"
            >
              Reset Filtros
            </button>
          </div>
        </div>
        
        {error && (
          <div className="mb-4 p-3 bg-rose-500/20 border border-rose-500/30 rounded-xl text-rose-400">
            {error}
          </div>
        )}
        
        <div className="mb-6">
          <div className="grid grid-cols-2 md:grid-cols-4 gap-3 mb-4">
            <div>
              <label className="block text-sm font-medium text-zinc-400 mb-1">Status</label>
              <select
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
                value={filters.category}
                onChange={handleFilterChange}
                className="w-full px-3 py-1 rounded border border-zinc-800 bg-zinc-900/50 text-zinc-300 focus:outline-none focus:ring-2 focus:ring-zinc-600"
              >
                <option value="">Todas as Categorias</option>
                {categoriesData.map((cat) => (
                  <option key={cat.id} value={cat.id}>
                    {cat.name}
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
        
        {loading ? (
          <div className="text-center py-12">
            <div className="animate-spin rounded-full h-8 w-8 border-b-2 border-emerald-500"></div>
            <p className="mt-2 text-zinc-400">Carregando ferramentas...</p>
          </div>
        ) : (
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
                    <td colSpan="6" className="py-8 text-center text-zinc-500">
                      Nenhuma ferramenta encontrada com os filtros aplicados
                    </td>
                  </tr>
                )}
              </tbody>
            </table>
          </div>
        )}
        
        {/* Pagination would go here if needed */}
      </div>
    </main>
  );
}
