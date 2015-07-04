class Parser

  parseCommit: (repo, _json, cb) ->
    models = [];

    for commit in _json
      model = {}
      model.commit_id = commit.sha
      model.repository_id = repo
      model.commit_author = commit.author.login
      model.commit_detail_url = commit.url
      model.commit_view_url = commit.html_url
      model.commit_message = commit.commit.message
      model.commit_date = commit.commit.committer.date
      models.push model

    cb models

module.exports = Parser