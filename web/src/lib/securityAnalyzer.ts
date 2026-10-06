export interface SecurityAnalysisResult {
  riskLevel: 'LOW' | 'MEDIUM' | 'HIGH';
  reasons: string[];
  notDetected: string[];
  analysisVersion: string;
  analyzedAt: string; // ISO timestamp
}

/**
 * Analyze a script for security risks based on predefined patterns
 * @param script The script content to analyze
 * @returns Security analysis result
 */
export function analyzeSecurity(script: string): SecurityAnalysisResult {
  if (!script || script.trim() === '') {
    return {
      riskLevel: 'LOW',
      reasons: ['Nenhum script fornecido para análise'],
      notDetected: [],
      analysisVersion: '1.0',
      analyzedAt: new Date().toISOString()
    };
  }

  const reasons: string[] = [];
  const notDetected: string[] = [];
  
  // Convert to uppercase for case-insensitive matching
  const upperScript = script.toUpperCase();
  
  // Define patterns for each risk level
  const lowRiskPatterns = [
    'IPCONFIG', 'PING', 'WHOAMI', 'HOSTNAME', 'SYSTEMINFO', 
    'ECHO', 'SET', 'DIR', 'CLS', 'TITLE', 'VER', 'DATE', 'TIME'
  ];
  
  const mediumRiskPatterns = [
    'REG ', 'SCHTASKS', 'SC ', 'NET USER', 'NET LOCALGROUP', 
    'POWERSHELL', 'WMIC', 'WEVTUTIL', 'TAKEOWN', 'ICACLS'
  ];
  
  const highRiskPatterns = [
    'POWERSHELL -ENC', 'ENCODEDCOMMAND', 'DOWNLOADSTRING', 
    'INVOKE-WEBREQUEST', 'CURL', 'WGET', 'CERTUTIL', 'BITSADMIN',
    'MSHTA', 'RUNDLL32', 'REGSVR32'
  ];
  
  const criticalPatterns = [
    'DEL /F', 'FORMAT', 'DISKPART', 'BCDEDIT', 'CIPHER /W',
    'REMOVE-ITEM', 'SET-EXECUTIONPOLICY'
  ];
  
  // Check for LOW risk patterns (these are generally safe but we note them)
  // Actually, we don't add reasons for LOW risk patterns since they're safe
  // We'll use them to determine if ONLY low risk patterns are present
  
  // Check for MEDIUM risk patterns
  let hasMediumRisk = false;
  for (const pattern of mediumRiskPatterns) {
    if (upperScript.includes(pattern)) {
      hasMediumRisk = true;
      // Add specific reason based on pattern
      switch (pattern.trim()) {
        case 'REG ':
          reasons.push('⚠ Modifica o registro do Windows');
          break;
        case 'SCHTASKS':
          reasons.push('⚠ Agenda tarefas no Agendador de Tarefas');
          break;
        case 'SC ':
          reasons.push('⚠ Controla serviços do Windows');
          break;
        case 'NET USER':
        case 'NET LOCALGROUP':
          reasons.push('⚠ Modifica contas de usuário ou grupos locais');
          break;
        case 'POWERSHELL':
          reasons.push('⚠ Executa PowerShell');
          break;
        case 'WMIC':
          reasons.push('⚠ Usa WMIC para gerenciamento do sistema');
          break;
        case 'WEVTUTIL':
          reasons.push('⚠ Acessa logs de eventos do Windows');
          break;
        case 'TAKEOWN':
          reasons.push('⚠ Altera propriedade de arquivos ou pastas');
          break;
        case 'ICACLS':
          reasons.push('⚠ Modifica listas de controle de acesso (ACL)');
          break;
      }
    }
  }
  
  // Check for HIGH risk patterns
  let hasHighRisk = false;
  for (const pattern of highRiskPatterns) {
    if (upperScript.includes(pattern)) {
      hasHighRisk = true;
      // Add specific reason based on pattern
      switch (pattern) {
        case 'POWERSHELL -ENC':
          reasons.push('⚠ PowerShell com comando codificado (possível ofuscação)');
          break;
        case 'ENCODEDCOMMAND':
          reasons.push('⚠ PowerShell EncodedCommand detectado');
          break;
        case 'DOWNLOADSTRING':
          reasons.push('⚠ Tentativa de download e execução de código remoto');
          break;
        case 'INVOKE-WEBREQUEST':
          reasons.push('⚠ Invoke-WebRequest usado para baixar conteúdo da web');
          break;
        case 'CURL':
        case 'WGET':
          reasons.push('⚠ Ferramenta de download de arquivos da internet detectada');
          break;
        case 'CERTUTIL':
          reasons.push('⚠ CertUtil pode ser usado para baixar ou decodificar arquivos');
          break;
        case 'BITSADMIN':
          reasons.push('⚠ BITSAdmin usado para transferências de arquivo');
          break;
        case 'MSHTA':
          reasons.push('⚠ MSHTA pode executar código HTML/JavaScript malicioso');
          break;
        case 'RUNDLL32':
          reasons.push('⚠ Rundll32 pode executar código arbitrário de DLLs');
          break;
        case 'REGSVR32':
          reasons.push('⚠ Regsvr32 pode registrar e executar DLLs maliciosas');
          break;
      }
    }
  }
  
  // Check for CRITICAL/HIGH risk patterns (file system damage, etc.)
  let hasCriticalRisk = false;
  for (const pattern of criticalPatterns) {
    if (upperScript.includes(pattern)) {
      hasCriticalRisk = true;
      // Add specific reason based on pattern
      switch (pattern) {
        case 'DEL /F':
          reasons.push('⚠ Exclusão forçada de arquivos detectada');
          break;
        case 'FORMAT':
          reasons.push('⚠ Comando de formatação de unidade detectado');
          break;
        case 'DISKPART':
          reasons.push('⚠ DiskPart pode particionar ou formatar unidades');
          break;
        case 'BCDEDIT':
          reasons.push('⚠ BCDedit modifica dados de configuração de inicialização');
          break;
        case 'CIPHER /W':
          reasons.push('⚠ Cipher /w pode limpar espaço livre do disco');
          break;
        case 'REMOVE-ITEM':
          reasons.push('⚠ Remove-Item pode excluir arquivos e pastas');
          break;
        case 'SET-EXECUTIONPOLICY':
          reasons.push('⚠ Set-ExecutionPolicy altera políticas de execução do PowerShell');
          break;
      }
    }
  }
  
  // What was NOT detected (for transparency)
  const safePatterns = [
    'DOWNLOADSTRING', 'INVOKE-WEBREQUEST', 'CURL', 'WGET', 
    'CERTUTIL', 'BITSADMIN', 'MSHTA', 'RUNDLL32', 'REGSVR32',
    'ENCODEDCOMMAND', 'POWERSHELL -ENC',
    'REG ', 'SCHTASKS', 'SC ', 'NET USER', 'NET LOCALGROUP',
    'DEL /F', 'FORMAT', 'DISKPART', 'BCDEDIT', 'CIPHER /W',
    'REMOVE-ITEM', 'SET-EXECUTIONPOLICY'
  ];
  
  for (const pattern of safePatterns) {
    if (!upperScript.includes(pattern)) {
      // Only add to notDetected if it's a security-relevant pattern
      const securityRelevantPatterns = [
        'DOWNLOADSTRING', 'INVOKE-WEBREQUEST', 'CURL', 'WGET', 
        'CERTUTIL', 'BITSADMIN', 'MSHTA', 'RUNDLL32', 'REGSVR32',
        'ENCODEDCOMMAND', 'POWERSHELL -ENC',
        'REG ', 'SCHTASKS', 'SC ', 'NET USER', 'NET LOCALGROUP',
        'DEL /F', 'FORMAT', 'DISKPART', 'BCDEDIT', 'CIPHER /W',
        'REMOVE-ITEM', 'SET-EXECUTIONPOLICY'
      ];
      if (securityRelevantPatterns.includes(pattern)) {
        notDetected.push(`✓ Nenhum padrão de ${pattern.trim()} detectado`);
      }
    }
  }
  
  // Determine risk level based on findings
  let riskLevel: 'LOW' | 'MEDIUM' | 'HIGH' = 'LOW';
  
  if (hasHighRisk || hasCriticalRisk) {
    riskLevel = 'HIGH';
  } else if (hasMediumRisk) {
    riskLevel = 'MEDIUM';
  } else {
    riskLevel = 'LOW';
    // If no risks detected, add a positive note
    if (reasons.length === 0) {
      reasons.push('✓ Nenhum padrão de risco significativo detectado');
    }
  }
  
  // Remove duplicate reasons
  const uniqueReasons = [...new Set(reasons)];
  
  return {
    riskLevel,
    reasons: uniqueReasons,
    notDetected: [...new Set(notDetected)],
    analysisVersion: '1.0',
    analyzedAt: new Date().toISOString()
  };
}
