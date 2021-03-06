require 'spec_helper'

describe JobListingsController do
  let(:company) { create(:company) }
  let(:subscription) { create(:subscription, company_id: company.id, started_at: Time.now) }

  before :each do
    company.subscription = subscription
    subscription.stub(:maxed_out?).and_return(false)
  end

  describe '#index' do
    let(:job_listings) { create_list(:job_listing, 3, company: company) }
    before :each do
      Company.stub(:find).and_return(company)
      company.stub_chain(:job_listings, :order, :paginate).and_return(job_listings)
      get(:index, {company_id: company.id})
    end
    it { should respond_with(:success) }
    it('assigns job_listings variable') { assigns(:job_listings).should =~ job_listings }
    it('assigns company variable') { assigns(:company).should eq company }
  end

  describe '#show' do
    let(:job_listing) { create(:job_listing) }
    let(:conversations) { double(Conversation) }
    before :each do
      expect(JobListing).to receive(:find).and_return(job_listing)
      Company.stub(:find).and_return(company)
      job_listing.stub(:conversations).and_return(conversations)
      get(:show, {company_id: company.id, id: job_listing.id})
    end
    it { should respond_with(:success) }
    it('assigns job_listing variable') { assigns(:job_listing).should eq job_listing }
    it('assigns company variable') { assigns(:company).should eq company }
  end

  describe '#new' do

  end

  describe '#create' do

  end

  describe '#update_listing' do

  end

  describe '#retrieve_listing' do

  end

  describe '#destroy' do
    let(:job_listing) { create(:job_listing, active: true) }
    before :each do
      company_login(company)
      Company.stub(:find).and_return(company)
      JobListing.stub(:find).and_return(job_listing)
      expect(job_listing).to receive(:destroy)
      delete(:destroy, {company_id: company.id, id: job_listing.id})
    end
    it { should respond_with(:redirect) }
    it { should redirect_to(company_job_listings_path(company_id: company.id)) }
  end

  describe '#toggle_active' do
    context 'activated' do
      let(:job_listing) { create(:job_listing, active: true) }
      before :each do
        company_login(company)
        Company.stub(:find).and_return(company)
        JobListing.stub(:find).and_return(job_listing)
        put(:toggle_active, {company_id: company.id, id: job_listing.id})
      end
      it { should respond_with(:redirect) }
      it { should redirect_to(company_job_listings_path(company_id: company.id)) }
      it 'deactivates the job listing' do
        job_listing.should_not be_active
      end
    end
    context 'deactivated' do
      let(:job_listing) { create(:job_listing, active: false) }
      before :each do
        company_login(company)
        Company.stub(:find).and_return(company)
        JobListing.stub(:find).and_return(job_listing)
      end
      context 'when a company is under the maximum number of job listings' do
        before :each do
          put(:toggle_active, {company_id: company.id, id: job_listing.id})
        end
        it { should respond_with(:redirect) }
        it { should redirect_to(company_job_listings_path(company_id: company.id)) }
        it 'deactivates the job listing' do
          job_listing.should be_active
        end
      end
      context 'when a company has already reached the maximum number of job listings' do
        before :each do
          subscription.stub(:maxed_out?).and_return(true)
          put(:toggle_active, {company_id: company.id, id: job_listing.id})
        end
        it { should respond_with(:redirect) }
        it { should redirect_to(company_job_listings_path(company_id: company.id)) }
        it 'should not activate the job listing' do
          job_listing.should_not be_active
        end
      end
    end
  end
end
