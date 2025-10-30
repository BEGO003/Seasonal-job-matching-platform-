// server.js
const jsonServer = require('json-server');
const server = jsonServer.create();
const router = jsonServer.router('db.json');
const middlewares = jsonServer.defaults();

// Use default middlewares
server.use(middlewares);
server.use(jsonServer.bodyParser);

// Helper function to get database instance
const getDB = () => {
  return router.db;
};

// Custom routes - Applied Jobs with Job Details
server.get('/api/users/:id/applied-jobs', (req, res) => {
  const userId = parseInt(req.params.id);
  const db = getDB();
  
  try {
    console.log(`Fetching applied jobs for user ${userId}`);
    
    // Get user's applications from the applications array
    const applications = db.get('applications')
      .filter(app => app.userID === userId)
      .value();
    
    console.log(`Found ${applications.length} applications for user ${userId}`);
    
    // Get job details for each application
    const appliedJobs = applications.map(app => {
      const job = db.get('jobs').find({ id: app.jobID }).value();
      console.log(`Application ${app.id} -> Job ${app.jobID}:`, job ? job.title : 'Not found');
      return {
        application: app,
        job: job
      };
    }).filter(item => item.job !== undefined);
    
    console.log(`Returning ${appliedJobs.length} applied jobs`);
    res.json(appliedJobs);
  } catch (error) {
    console.error('Error in /api/users/:id/applied-jobs:', error);
    res.status(500).json({ error: error.message });
  }
});

// User's applications only
server.get('/api/users/:id/applications', (req, res) => {
  const userId = parseInt(req.params.id);
  const db = getDB();
  
  try {
    console.log(`Fetching applications for user ${userId}`);
    
    const applications = db.get('applications')
      .filter(app => app.userID === userId)
      .value();
    
    console.log(`Found ${applications.length} applications`);
    res.json(applications);
  } catch (error) {
    console.error('Error in /api/users/:id/applications:', error);
    res.status(500).json({ error: error.message });
  }
});

// User's favorite jobs
server.get('/api/users/:id/favorite-jobs', (req, res) => {
  const userId = parseInt(req.params.id);
  const db = getDB();
  
  try {
    console.log(`Fetching favorite jobs for user ${userId}`);
    
    const user = db.get('users').find({ id: userId }).value();
    console.log('User found:', user ? user.name : 'Not found');
    
    if (user && user.favoriteJobs && Array.isArray(user.favoriteJobs)) {
      console.log('User favoriteJobs array:', user.favoriteJobs);
      
      const favoriteJobs = user.favoriteJobs.map(jobId => {
        const job = db.get('jobs').find({ id: jobId }).value();
        console.log(`Favorite job ${jobId}:`, job ? job.title : 'Not found');
        return job;
      }).filter(job => job !== undefined);
      
      console.log(`Returning ${favoriteJobs.length} favorite jobs`);
      res.json(favoriteJobs);
    } else {
      console.log('No favorite jobs found or invalid data');
      res.json([]);
    }
  } catch (error) {
    console.error('Error in /api/users/:id/favorite-jobs:', error);
    res.status(500).json({ error: error.message });
  }
});

// Jobs posted by user (owned jobs)
server.get('/api/users/:id/owned-jobs', (req, res) => {
  const userId = parseInt(req.params.id);
  const db = getDB();
  
  try {
    console.log(`Fetching owned jobs for user ${userId}`);
    
    const user = db.get('users').find({ id: userId }).value();
    console.log('User found:', user ? user.name : 'Not found');
    
    if (user && user.ownedjobs && Array.isArray(user.ownedjobs)) {
      console.log('User ownedjobs array:', user.ownedjobs);
      
      const ownedJobs = user.ownedjobs.map(jobId => {
        const job = db.get('jobs').find({ id: jobId }).value();
        console.log(`Owned job ${jobId}:`, job ? job.title : 'Not found');
        return job;
      }).filter(job => job !== undefined);
      
      console.log(`Returning ${ownedJobs.length} owned jobs`);
      res.json(ownedJobs);
    } else {
      console.log('No owned jobs found or invalid data');
      res.json([]);
    }
  } catch (error) {
    console.error('Error in /api/users/:id/owned-jobs:', error);
    res.status(500).json({ error: error.message });
  }
});

// Get user by ID with all related data
server.get('/api/users/:id/full', (req, res) => {
  const userId = parseInt(req.params.id);
  const db = getDB();
  
  try {
    console.log(`Fetching full user data for user ${userId}`);
    
    const user = db.get('users').find({ id: userId }).value();
    if (!user) {
      return res.status(404).json({ error: 'User not found' });
    }
    
    // Get applied jobs
    const applications = db.get('applications')
      .filter(app => app.userID === userId)
      .value();
    
    const appliedJobs = applications.map(app => {
      const job = db.get('jobs').find({ id: app.jobID }).value();
      return {
        application: app,
        job: job
      };
    }).filter(item => item.job !== undefined);
    
    // Get favorite jobs
    const favoriteJobs = (user.favoriteJobs || []).map(jobId => 
      db.get('jobs').find({ id: jobId }).value()
    ).filter(job => job !== undefined);
    
    // Get owned jobs
    const ownedJobs = (user.ownedjobs || []).map(jobId => 
      db.get('jobs').find({ id: jobId }).value()
    ).filter(job => job !== undefined);
    
    // Get resume
    const resume = user.resume ? db.get('resumes').find({ id: user.resume }).value() : null;
    
    const userWithRelations = {
      ...user,
      appliedJobs: appliedJobs,
      favoriteJobs: favoriteJobs,
      ownedJobs: ownedJobs,
      resume: resume
    };
    
    console.log(`Returning full user data with ${appliedJobs.length} applied jobs, ${favoriteJobs.length} favorite jobs, ${ownedJobs.length} owned jobs`);
    res.json(userWithRelations);
  } catch (error) {
    console.error('Error in /api/users/:id/full:', error);
    res.status(500).json({ error: error.message });
  }
});

// Debug endpoint to see all data
server.get('/api/debug/data', (req, res) => {
  const db = getDB();
  
  try {
    const users = db.get('users').value();
    const jobs = db.get('jobs').value();
    const applications = db.get('applications').value();
    const resumes = db.get('resumes').value();
    
    const debugData = {
      users: users.map(user => ({
        id: user.id,
        name: user.name,
        ownedjobs: user.ownedjobs,
        favoriteJobs: user.favoriteJobs,
        ownedapplications: user.ownedapplications
      })),
      jobs: jobs.map(job => ({
        id: job.id,
        title: job.title,
        jobposter: job.jobposter
      })),
      applications: applications.map(app => ({
        id: app.id,
        userID: app.userID,
        jobID: app.jobID,
        status: app.applicationstatus
      })),
      stats: {
        totalUsers: users.length,
        totalJobs: jobs.length,
        totalApplications: applications.length,
        totalResumes: resumes.length
      }
    };
    
    res.json(debugData);
  } catch (error) {
    console.error('Error in /api/debug/data:', error);
    res.status(500).json({ error: error.message });
  }
});

// Test specific user endpoint
server.get('/api/debug/user/:id', (req, res) => {
  const userId = parseInt(req.params.id);
  const db = getDB();
  
  try {
    const user = db.get('users').find({ id: userId }).value();
    if (!user) {
      return res.status(404).json({ error: 'User not found' });
    }
    
    const testResults = {
      user: {
        id: user.id,
        name: user.name,
        ownedjobs: user.ownedjobs,
        favoriteJobs: user.favoriteJobs,
        ownedapplications: user.ownedapplications
      },
      ownedJobs: user.ownedjobs ? user.ownedjobs.map(jobId => {
        const job = db.get('jobs').find({ id: jobId }).value();
        return { jobId, found: !!job, title: job ? job.title : null };
      }) : [],
      favoriteJobs: user.favoriteJobs ? user.favoriteJobs.map(jobId => {
        const job = db.get('jobs').find({ id: jobId }).value();
        return { jobId, found: !!job, title: job ? job.title : null };
      }) : [],
      applications: db.get('applications').filter(app => app.userID === userId).value().map(app => ({
        id: app.id,
        jobID: app.jobID,
        status: app.applicationstatus,
        job: db.get('jobs').find({ id: app.jobID }).value()?.title
      }))
    };
    
    res.json(testResults);
  } catch (error) {
    console.error('Error in /api/debug/user/:id:', error);
    res.status(500).json({ error: error.message });
  }
});

// The rest of your existing endpoints...
server.get('/api/jobs/:id/applications', (req, res) => {
  const jobId = parseInt(req.params.id);
  const db = getDB();
  
  try {
    const applications = db.get('applications')
      .filter(app => app.jobID === jobId)
      .value();
    
    const applicationsWithUsers = applications.map(app => {
      const user = db.get('users').find({ id: app.userID }).value();
      return {
        ...app,
        user: user
      };
    });
    
    res.json(applicationsWithUsers);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// Search jobs
server.get('/api/jobs/search', (req, res) => {
  const { q, category, type, location } = req.query;
  const db = getDB();
  
  try {
    let jobs = db.get('jobs').value();
    
    if (q) {
      jobs = jobs.filter(job => 
        job.title.toLowerCase().includes(q.toLowerCase()) ||
        job.company.toLowerCase().includes(q.toLowerCase()) ||
        job.description.toLowerCase().includes(q.toLowerCase())
      );
    }
    
    if (category) {
      jobs = jobs.filter(job => 
        job.category.toLowerCase().includes(category.toLowerCase())
      );
    }
    
    if (type) {
      jobs = jobs.filter(job => 
        job.type.toLowerCase().includes(type.toLowerCase())
      );
    }
    
    if (location) {
      jobs = jobs.filter(job => 
        job.location.toLowerCase().includes(location.toLowerCase())
      );
    }
    
    res.json(jobs);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// Use JSON Server router
server.use(router);

// Start server
const PORT = 3000;
server.listen(PORT, () => {
  console.log('🚀 Fixed JSON Server is running on http://localhost:' + PORT);
  console.log('📋 Debug Endpoints:');
  console.log('   GET /api/debug/data - See all data relationships');
  console.log('   GET /api/debug/user/:id - Test specific user data');
  console.log('   GET /api/users/:id/full - Get user with all relationships');
  console.log('\n📋 Custom Endpoints:');
  console.log('   GET /api/users/:id/applied-jobs');
  console.log('   GET /api/users/:id/applications');
  console.log('   GET /api/users/:id/favorite-jobs');
  console.log('   GET /api/users/:id/owned-jobs');
  console.log('   GET /api/jobs/:id/applications');
  console.log('   GET /api/jobs/search?q=query&category=cat&type=type&location=loc');
});