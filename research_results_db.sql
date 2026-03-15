-- =============================================
-- AI Deep Research Agent — Results Database
-- Run this in your Supabase SQL Editor
-- =============================================

-- Research sessions table
CREATE TABLE IF NOT EXISTS research_sessions (
  id            UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  topic         TEXT NOT NULL,
  depth         INTEGER DEFAULT 2,
  breadth       INTEGER DEFAULT 4,
  status        TEXT CHECK (status IN ('running', 'completed', 'failed')) DEFAULT 'running',
  started_at    TIMESTAMPTZ DEFAULT NOW(),
  completed_at  TIMESTAMPTZ
);

-- Individual learnings from each search
CREATE TABLE IF NOT EXISTS research_learnings (
  id            UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  session_id    UUID REFERENCES research_sessions(id) ON DELETE CASCADE,
  learning      TEXT NOT NULL,
  source_url    TEXT,
  depth_level   INTEGER DEFAULT 1,
  created_at    TIMESTAMPTZ DEFAULT NOW()
);

-- Final compiled reports
CREATE TABLE IF NOT EXISTS research_reports (
  id            UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  session_id    UUID REFERENCES research_sessions(id) ON DELETE CASCADE,
  topic         TEXT NOT NULL,
  report        TEXT NOT NULL,
  total_sources INTEGER DEFAULT 0,
  created_at    TIMESTAMPTZ DEFAULT NOW()
);

-- Index for fast lookups by session
CREATE INDEX IF NOT EXISTS learnings_session_idx
ON research_learnings (session_id);

CREATE INDEX IF NOT EXISTS reports_session_idx
ON research_reports (session_id);

-- View: Full research summary
CREATE OR REPLACE VIEW research_summary AS
SELECT
  s.id,
  s.topic,
  s.depth,
  s.breadth,
  s.status,
  COUNT(l.id)           AS total_learnings,
  r.total_sources,
  s.started_at,
  s.completed_at,
  EXTRACT(EPOCH FROM (s.completed_at - s.started_at))::INT AS duration_seconds
FROM research_sessions s
LEFT JOIN research_learnings l ON l.session_id = s.id
LEFT JOIN research_reports   r ON r.session_id = s.id
GROUP BY s.id, r.total_sources
ORDER BY s.started_at DESC;
