# frozen_string_literal: true

require 'rails_helper'

describe 'dra_scores', type: :request do
  let(:headers) do
    {
      'Accept' => 'application/vnd.api+json',
      'Content-Type' => 'application/vnd.api+json'
    }
  end
  let(:params) { { dra_score: dra_score }.to_json }

  subject do
    request!

    response
  end

  describe 'GET index' do
    before do
      dra_scores
    end

    let(:request!) { get dra_scores_path, headers: headers }

    context 'when there are no dra_scores' do
      let(:dra_scores) {}

      it { is_expected.to have_http_status(:ok) }
      it 'should return an empty array' do
        body = JSON.parse(subject.body)

        expect(body).to be_empty
      end
    end

    context 'when there are dra_scores' do
      let(:dra_scores) { create_list(:dra_score, 2) }

      it { is_expected.to have_http_status(:ok) }
      it 'should return a list of dra_scores' do
        body = JSON.parse(subject.body)

        expect(body.size).to eq(dra_scores.size)

        body.each_with_index do |dra_score, index|
          expect(dra_score['id']).to eq(dra_scores[index].id)
          expect(dra_score['dra_level']).to eq(dra_scores[index].dra_level)
          expect(dra_score['rank']).to eq(dra_scores[index].rank)
        end
      end
    end
  end

  describe 'GET show' do
    before do
      dra_score_id
    end

    let(:request!) { get dra_score_path(dra_score_id) }

    context 'when the dra_score can be found' do
      let(:dra_score) { create(:dra_score) }
      let(:dra_score_id) { dra_score.id }

      it { is_expected.to have_http_status(:ok) }
      it 'should return a dra_score' do
        body = JSON.parse(subject.body)

        expect(body['id']).to eq(dra_score.id)
        expect(body['dra_level']).to eq(dra_score.dra_level)
        expect(body['rank']).to eq(dra_score.rank)
      end
    end

    context 'when the dra_score can not be found' do
      let(:dra_score_id) { SecureRandom.uuid }

      it { is_expected.to have_http_status(:not_found) }
      it 'should return an error message' do
        body = JSON.parse(subject.body)

        expect(body).to eq("Couldn't find DraScore with 'id'=#{dra_score_id}")
      end
    end
  end

  describe 'POST create' do
    let(:request!) do
      post dra_scores_path,
           params: params,
           headers: headers
    end

    context 'when the dra_score attributes are valid' do
      let(:dra_score) { attributes_for(:dra_score) }

      it { is_expected.to have_http_status(:ok) }
      it 'should return a success message' do
        message = JSON.parse(subject.body)['message']

        expect(message).to eq(I18n.t('dra_scores.create.success'))
      end
    end

    context 'when the dra_score attributes are not valid' do
      let(:dra_score) { attributes_for(:dra_score, rank: nil) }

      it { is_expected.to have_http_status(:unprocessable_entity) }
      it 'should return a success message' do
        message = JSON.parse(subject.body)['message']

        expect(message).to eq(I18n.t('dra_scores.create.failure'))
      end
    end
  end

  describe 'PATCH update' do
    let(:request!) do
      patch dra_score_path(dra_score_id),
            params: params,
            headers: headers
    end

    context 'when the dra_score is valid' do
      let(:params) do
        {
          dra_score: { rank: dra_score.rank + 1 }
        }.to_json
      end
      let(:dra_score) { create(:dra_score) }
      let(:dra_score_id) { dra_score.id }

      it { is_expected.to have_http_status(:ok) }
      it 'they see a success message' do
        body = JSON.parse(subject.body)

        expect(body['message']).to eq(I18n.t('dra_scores.update.success'))
        expect(body['resource']['rank']).to eq(dra_score.rank + 1)
      end
    end

    context 'when the dra_score is not valid' do
      let(:params) do
        {
          dra_score: { rank: 'test' }
        }.to_json
      end
      let(:dra_score) { create(:dra_score) }
      let(:dra_score_id) { dra_score.id }

      it { is_expected.to have_http_status(:unprocessable_entity) }
      it 'should return a success message' do
        message = JSON.parse(subject.body)['message']

        expect(message).to eq(I18n.t('dra_scores.update.failure'))
      end
    end

    context 'when the dra_score is not found' do
      let(:params) do
        {
          dra_score: { rank: dra_score.rank + 1 }
        }.to_json
      end
      let(:dra_score) { create(:dra_score) }
      let(:dra_score_id) { SecureRandom.uuid }

      it { is_expected.to have_http_status(:not_found) }
      it 'should return an error message' do
        body = JSON.parse(subject.body)

        expect(body).to eq("Couldn't find DraScore with 'id'=#{dra_score_id}")
      end
    end
  end
end
